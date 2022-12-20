-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
  }
})
