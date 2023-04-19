return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>l",  [[<cmd> lua require('harpoon.mark').add_file()<cr> ]],       desc = "Add file to harpoon" },
    { "<leader>fl", [[<cmd> lua require('harpoon.ui').toggle_quick_menu()<cr>]], desc = "Toggle quick menu" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("harpoon").setup({})
    require("telescope").load_extension('harpoon')
  end,
}
