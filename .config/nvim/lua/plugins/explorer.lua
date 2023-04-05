return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<C-b>", "<CMD>NvimTreeFindFileToggle<CR>", mode = { "n", "i", "v" } },
  },
  config = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup({
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
  end
}
