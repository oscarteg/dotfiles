local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })

  print("Installing packer.nvim. Restart Neovim")
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim") -- Required by most

  -- Coding
  use("vim-test/vim-test") -- Quick testing
  use("tpope/vim-dispatch") -- Execution
  use("github/copilot.vim") -- AI Code Completion
  use("mfussenegger/nvim-dap") -- Debugger
  use("numToStr/Comment.nvim") -- Comment Code

  -- Git
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  -- Text manipulation
  use("kylechui/nvim-surround") -- Surround text objects
  use("mattn/emmet-vim") -- Tag manipulation
  use("windwp/nvim-autopairs")

  -- Utils
  use('ThePrimeagen/harpoon') --  Bookmark management
  use("ThePrimeagen/refactoring.nvim") -- Refactoring
  use("folke/twilight.nvim") -- Zen mode
  use("folke/todo-comments.nvim")
  use({
    "nvim-neorg/neorg",
    requires = {
      "nvim-neorg/neorg-telescope",
    }
  })
  use("ggandor/leap.nvim") -- Motion
  use("mbbill/undotree")

  --- lsp package manager
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { "jose-elias-alvarez/null-ls.nvim" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- UI
  use("nvim-lualine/lualine.nvim")
  use('nyoom-engineering/oxocarbon.nvim')

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  -- Syntax
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("windwp/nvim-ts-autotag")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Languages
  use("simrat39/rust-tools.nvim") -- Rust
  use("rescript-lang/vim-rescript") -- Rescript
  use("ray-x/go.nvim") -- Go
  use("ziglang/zig.vim") -- Zig

  -- Explorer
  use("nvim-telescope/telescope.nvim") -- Fuzzy finder
  use("nvim-telescope/telescope-ui-select.nvim")
  use("nvim-telescope/telescope-file-browser.nvim")
  use("kyazdani42/nvim-tree.lua")


  if packer_bootstrap then
    require("packer").sync()
  end
end)
