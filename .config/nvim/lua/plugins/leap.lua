-- FIXME: Leap can't set it's key whenever we load Startify on startup
-- possibly because startify also map the `s` key
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
