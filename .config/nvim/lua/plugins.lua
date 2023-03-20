return {
  "nvim-lua/plenary.nvim", -- Required by most
  -- Coding
  { "tpope/vim-dispatch", event = "BufReadPre" },
  -- latex
  { "lervag/vimtex",      ft = "tex" }, -- Latex"
  -- Text manipulation
  {
    'willothy/moveline.nvim',
    build = "make",
    keys = {
      {
        "<M-k>",
        [[<cmd> lua require('moveline').up<cr>]],
      },

      {
        "<M-j>",
        [[<cmd> lua require('moveline').down<cr>]],
      },
      {
        "<M-k>",
        [[<cmd> lua require('moveline').block_up<cr>]],
        mode = "v"
      },
      {
        "<M-j>",
        [[<cmd> lua require('moveline').block_down<cr>]],
        mode = "v"
      },
    },
  },
  {
    "mattn/emmet-vim",
    ft = { 'html', 'css', 'scss', 'javascript', 'javascriptreact',
      'typescript', 'typescriptreact', 'sass', 'stylus', 'vue' }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = true,
    event = "BufReadPre"
  },
}
