local config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require 'luasnip'.config.setup()
end


return {
    { 'L3MON4D3/LuaSnip', dependencies = 'rafamadriz/friendly-snippets', config = config },
}
