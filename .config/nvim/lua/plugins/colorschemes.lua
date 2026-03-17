return {
  { "slugbyte/lackluster.nvim" },
  {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "datsfilipe/vesper.nvim",
    opts = {
      transparent = false,
      italics = {
        comments = true,
        keywords = true,
        functions = true,
        strings = false,
        variables = false,
      },
    },
  },
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "koda",
    },
  },
}
