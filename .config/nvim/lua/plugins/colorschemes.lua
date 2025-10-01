return {
  { "slugbyte/lackluster.nvim" },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        palette = {
          base = {
            base = "#ffffff",
            overlay = "#363738",
          },
        },
      })
    end,
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "bettervim/yugen.nvim" },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.adwaita_darker = true
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- require("kanagawa").load("dragon")
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- require("nordic").load()
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      -- local lush = require("lush")
      -- local rosebones = require("zenbones")
      --
      -- local spec = lush.extends({ rosebones }).with(function()
      --   return {
      --     Normal({ bg = "#111111" }),
      --   }
      -- end)
      --
      -- lush(spec)
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_foreground = "original"
    end,
  },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   config = function()
  --     require("gruvbox").setup({
  --       terminal_colors = true,
  --       dim_inactive = false,
  --       transparent_mode = false,
  --       palette_overrides = {
  --         dark0 = "#1C2021",
  --       },
  --     })
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  { "catppuccin/nvim", enabled = false },
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "deep ocean"
    end,
    opts = {
      plugins = {
        "dap",
        "flash",
        "gitsigns",
        "mini",
        "neo-tree",
        "nvim-notify",
        "nvim-tree",
        "neotest",
        "trouble",
        "telescope",
        "which-key",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "yugen",
    },
  },
}
