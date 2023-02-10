require("nvim-surround").setup()

require("todo-comments").setup({})

require("twilight").setup({
  treesitter = true,
})

require("leap").set_default_keymaps()

require('refactoring').setup({})
-- Harpoon (bookmarks manager)
require("harpoon").setup()
