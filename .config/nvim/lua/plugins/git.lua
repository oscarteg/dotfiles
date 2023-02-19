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
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      -- Reset
      map("n", "<leader>hR", gs.reset_buffer)
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
      -- Stage
      map("n", "<leader>hS", gs.stage_buffer)
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")

      map("n", "<leader>hu", gs.undo_stage_hunk)
      map("n", "<leader>hp", gs.preview_hunk)
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>tb", gs.toggle_current_line_blame)
      -- Diff
      map("n", "<leader>hd", gs.diffthis)
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end)
      map("n", "'r", gs.refresh)

      map("n", "<leader>td", gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "<leader>hi", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  })
end

return {
  {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    event = 'VeryLazy',
    config = config
  },
  {
    "tpope/vim-fugitive",
  }

}
