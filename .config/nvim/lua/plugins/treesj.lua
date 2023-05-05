return {
  'Wansmer/treesj',
  keys = {
    { '<leader>j', function() require('treesj').toggle() end },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false
    })
  end,
}
