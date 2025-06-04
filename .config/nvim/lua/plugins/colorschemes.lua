return {
  { "kdheepak/monochrome.nvim" },
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
    "ccxnu/rosebones",
    lazy = false,
    priority = 1000,
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
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
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
}
