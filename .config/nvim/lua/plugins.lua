local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })

  print("Installing packer.nvim. Restart Neovim")
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- git
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  -- text editing tools
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end,
  })
  use("mattn/emmet-vim")

  -- lsp
  use("neovim/nvim-lspconfig")
  use("nvim-lua/plenary.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  --- lsp package manager
  use("williamboman/mason.nvim")

  use("williamboman/mason-lspconfig.nvim")

  -- telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  -- comment
  use("numToStr/Comment.nvim")

  use("tpope/vim-dispatch")

  -- completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  use("windwp/nvim-autopairs")

  -- ui
  use("nvim-lualine/lualine.nvim")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  use("windwp/nvim-ts-autotag")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Themes
  use('kdheepak/monochrome.nvim')
  use({
    "catppuccin/nvim",
    as = "catppuccin",
  })

  use('Yazeed1s/oh-lucy.nvim')

  -- rust
  --[[ use("rust-lang/rust.vim") ]]
  use("simrat39/rust-tools.nvim")

  -- rescript
  use("rescript-lang/vim-rescript")

  -- Go
  use("ray-x/go.nvim")

  -- Zig
  use("ziglang/zig.vim")

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  })

  -- zen mode
  use({
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        treesitter = true,
      })
    end,
  })

  use({
    "nvim-neorg/neorg",
    requires = {
      "nvim-neorg/neorg-telescope",
    }
  })
  -- motion
  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
  })

  -- Dap debugger
  use("mfussenegger/nvim-dap")

  -- Explorer
  use("kyazdani42/nvim-tree.lua")

  -- refactoring
  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
