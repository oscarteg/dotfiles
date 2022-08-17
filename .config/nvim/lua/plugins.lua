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

  use("tpope/vim-surround")
  use("tpope/vim-repeat")

  -- lsp
  use("neovim/nvim-lspconfig")
  use("nvim-lua/plenary.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  -- telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")

  -- comment
  use("numToStr/Comment.nvim")

  -- Note taking
  use("mickael-menu/zk-nvim")

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
  use("mattn/emmet-vim")
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "kanagawa",
          globalstatus = true,
        },
      })
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  use("windwp/nvim-ts-autotag")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Themes
  use("EdenEast/nightfox.nvim")
  use("Domeee/mosel.nvim")
  use({
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup({
        overrides = function()
          if vim.o.background == "dark" then
            return { NormalNC = { bg = "#0f151e", fg = "#808080" } }
          else
            return { NormalNC = { bg = "#f0f0f0", fg = "#808080" } }
          end
        end,
      })
    end,
  })

  use("folke/tokyonight.nvim")

  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        integrations = {
          barbar = true,
        },
      })
    end,
  })

  use({
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        globalStatus = true,
      })
    end,
  })

  -- Package manager for Neovim
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({})
    end,
  })

  -- languages
  -- rust
  use("rust-lang/rust.vim")
  use("simrat39/rust-tools.nvim")

  -- rescript
  use("rescript-lang/vim-rescript")

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

  -- END LANGUAGES

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
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
  })

  -- Dap debugger
  use("mfussenegger/nvim-dap")

  -- Explorer
  use("kyazdani42/nvim-tree.lua")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
