require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        git = false,
        folder = false,
        file = false,
        folder_arrow = false,
      },
    },
  },
  view = {
    mappings = {
      list = {
        { key = "<CR>", action = "edit_in_place" },
      },
    },
  },
})
