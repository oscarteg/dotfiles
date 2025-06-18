return {
  { "slugbyte/lackluster.nvim" },
  { "kdheepak/monochrome.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "bettervim/yugen.nvim" },
  { "rose-pine/neovim" },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.adwaita_darker = true
    end,
  },

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
    config = function()
      local lush = require("lush")
      local rosebones = require("zenbones")

      local spec = lush.extends({ rosebones }).with(function()
        return {
          Normal({ bg = "#111111" }),
        }
      end)

      lush(spec)
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        dim_inactive = false,
        transparent_mode = false,
        palette_overrides = {
          dark0 = "#1C2021",
        },
      })
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
      colorscheme = "lackluster-mint",
    },
  },
}
