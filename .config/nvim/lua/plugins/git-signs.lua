-- Do not load up plugin when in diff mode.
local config = function()
  if vim.opt.diff:get() then
    return
  end

  local present, gitsigns = pcall(require, "gitsigns")
  if not present then
    return
  end

  gitsigns.setup({
    current_line_blame = true,
    signs = {
      add = { hl = "GitSignsAdd", text = "┃" },
      change = { hl = "GitSignsChange", text = "┃" },
      delete = { hl = "GitSignsDelete", text = "▁" },
      topdelete = { hl = "GitSignsDelete", text = "▔" },
      changedelete = { hl = "GitSignsChangeDelete", text = "┃" },
      untracked = { hl = "GitSignsUntracked", text = "┃" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]v", function()
        if vim.wo.diff then
          return "]v"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next hunk" })

      map("n", "[v", function()
        if vim.wo.diff then
          return "[v"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous hunk" })

      -- Actions
      -- Reset
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
      -- Stage
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })

      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>hb", function()
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        gs.blame_line({ full = true })
      end, { desc = "Blame line" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
      -- Diff
      map("n", "<leader>hD", function()
        gs.diffthis("~")
        map("n", "'r", gs.refresh)
      end, { desc = "Diff this (cached)" })

      map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

      -- Text object
      map({ "o", "x" }, "<leader>hi", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
  })
end

return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = config
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename",
      "Glgrep", "Gedit", "Gsplit", "Gvsplit", "Gtabedit" },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFocusFiles" }
  }

}
