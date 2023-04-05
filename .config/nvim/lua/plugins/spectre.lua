return {
  'nvim-pack/nvim-spectre',
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    {
      "<leader>sw",
      function() require("spectre").open_visual({ select_word = true }) end,
      desc =
      "Search current word"
    },
    {
      "<leader>sw",
      function() require("spectre").open_visual() end,
      desc =
      "Search current word",
      mode = "v"
    },
    {
      "<leader>sp",
      function() require("spectre").open_file_search({ select_word = true }) end,
      desc =
      "Replace in files (Spectre) current buffer"
    },

  },
}
