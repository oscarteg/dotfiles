return {
  { "slugbyte/lackluster.nvim" },
  { "datsfilipe/vesper.nvim" },
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
      require("kanagawa").setup({
        theme = "wave",
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        colors = {
          palette = {
            sumiInk1 = "#0D101B",
            sumiInk0 = "#0D101B", -- Used for statusline and floating windows
          },
          theme = {
            wave = {
              ui = {
                bg = "#0D101B",
                bg_gutter = "#0D101B",
              },
            },
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("bufferline").setup({
        highlights = require("vesper").bufferline.highlights,
      })
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
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
      end,
      update_interval = 3000,
      fallback = "dark",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vesper",
    },
  },
}
