local function lsp_name()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then
    return msg
  end

  local lsps = {}

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      table.insert(lsps, client.name)
    end
  end
  --
  msg = table.concat(lsps, ", ")
  return msg
end

local custom_base16 = require('lualine.themes.base16')

custom_base16.normal.a.bg = "#ffd700"

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = custom_base16,
    globalstatus = true,
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
    lualine_x = { lsp_name },
    lualine_y = { "filetype" },
    lualine_z = { "progress" },
  },
})
