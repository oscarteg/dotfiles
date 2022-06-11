local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })

  print("Installing packer.nvim. Restart Neovim")
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Git
  use("tpope/vim-fugitive")
  use("airblade/vim-gitgutter")

  -- Change or add surrounin
  use("tpope/vim-surround")
  use("neovim/nvim-lspconfig")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")
  use("kyazdani42/nvim-web-devicons")

  use("numToStr/Comment.nvim")

  use("jose-elias-alvarez/null-ls.nvim")

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  })

  -- Note taking
  use("mickael-menu/zk-nvim")

  -- completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")
  -- completion end
  use("windwp/nvim-autopairs")
  use("mattn/emmet-vim")
  use("nvim-lualine/lualine.nvim")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/playground")
  use("windwp/nvim-ts-autotag")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Themes
  use("EdenEast/nightfox.nvim")
  use("Domeee/mosel.nvim")

  -- Rust
  use("rust-lang/rust.vim")
  use("simrat39/rust-tools.nvim")

  -- Go
  use("crispgm/nvim-go")

  -- Zig
  use("ziglang/zig.vim")

  -- Lisp
  use({
    "vlime/vlime",
    config = function()
      rtp = "vim/"
    end,
  })

  -- Zen mode
  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({})
    end,
  })

  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
