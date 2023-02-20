return {
  "nvim-lua/plenary.nvim", -- Required by most
  -- Coding
  { "tpope/vim-dispatch", event = "BufReadPre" },
  { "github/copilot.vim",
    event = 'VeryLazy'
  }, -- AI Code Completion

  -- latex
  { "lervag/vimtex",      ft = "tex" }, -- Latex"
  -- Text manipulation
  { "mattn/emmet-vim",
    ft = { 'html', 'css', 'scss', 'javascript', 'javascriptreact',
      'typescript', 'typescriptreact', 'sass', 'stylus', 'vue' }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = true,
    event = "BufReadPre"
  },
}
