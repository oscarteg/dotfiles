return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<C-b>", "<CMD>NvimTreeToggle<CR>", mode = { "n", "i", "v" } }
  },
  config = true,
  opts = {
    renderer = {
      icons = {
        show = {
          -- git = false,
          -- folder = false,
          file = false,
          folder_arrow = false,
        },
      },
    }
  }
}
