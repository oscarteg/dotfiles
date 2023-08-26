return {
  { "ellisonleao/gruvbox.nvim" },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa")
      -- vim.cmd("colorscheme kanagawa-dragon")
    end
  }
}
