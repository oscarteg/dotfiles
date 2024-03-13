return {
  'nvim-pack/nvim-spectre',
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "[S]earch and [R]eplace in files" },
    {
      "<leader>sw",
      function() require("spectre").open_visual({ select_word = true }) end,
      desc =
      "[S]earch current word"
    },
    {
      "<leader>sw",
      function() require("spectre").open_visual() end,
      desc =
      "[S]earch current word",
      mode = "v"
    },
    {
      "<leader>sp",
      function() require("spectre").open_file_search({ select_word = true }) end,
      desc =
      "[S]earch on current file"
    },
  },
}
