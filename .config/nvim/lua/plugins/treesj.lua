return {
  'Wansmer/treesj',
  keys = { '<leader>j' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false
    })

    vim.keymap.set('n', '<leader>j', require('treesj').toggle)
  end,
}
