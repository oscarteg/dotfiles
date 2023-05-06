return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.setup({
      plugins = { spelling = true },
      key_labels = { ["<leader>"] = "SPC" },
    })
    wk.register({
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>da"] = { name = "+adapters" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/telescope" },
      ["<leader>h"] = { name = "+git/help" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>t"] = { name = "+toggle" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["<leader>w"] = { name = "+windows" },
    })
  end,
}
