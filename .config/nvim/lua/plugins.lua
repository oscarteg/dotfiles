return {
  "nvim-lua/plenary.nvim", -- Required by most
  -- Coding
  { "tpope/vim-dispatch", event = "BufReadPre" },
  -- latex
  {
    "mattn/emmet-vim",
    ft = { 'html', 'css', 'scss', 'javascript', 'javascriptreact',
      'typescript', 'typescriptreact', 'sass', 'stylus', 'vue' }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    -- config = function()
    --   require("ibl").setup()
    -- end
  },
}
