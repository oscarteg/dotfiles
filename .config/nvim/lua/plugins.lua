return {
  "nvim-lua/plenary.nvim", -- Required by most
  -- Coding
  { "tpope/vim-dispatch", event = "BufReadPre" },
  -- latex
  { "lervag/vimtex",      ft = "tex" }, -- Latex"
  -- Text manipulation
  {
    "mattn/emmet-vim",
    ft = { 'html', 'css', 'scss', 'javascript', 'javascriptreact',
      'typescript', 'typescriptreact', 'sass', 'stylus', 'vue' }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    init = function()
      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
    end,
    config = function()
      require("indent_blankline").setup({
        space_char_blankline = " ",
      })
    end
  },
}
