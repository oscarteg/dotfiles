return {
  {
    'ggandor/leap.nvim',
    event = 'BufReadPost',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end,
  },
}
