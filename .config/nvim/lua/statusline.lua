local custom_base16 = require('lualine.themes.base16')

custom_base16.normal.a.bg = "#ffd700"

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = custom_base16,
    globalstatus = true,
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diagnostics", sources = { "nvim_lsp" } },
      "diff",
    },
    lualine_c = { {
      "filename",
      path = 1,
    } },
    lualine_y = { "filetype" },
    lualine_z = { "progress" },
  },
})
