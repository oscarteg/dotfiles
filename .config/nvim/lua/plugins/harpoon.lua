return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>l",  function() require('harpoon.mark').add_file() end,        desc = "Add file to harpoon" },
    { "<leader>fl", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Toggle quick menu" },
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
