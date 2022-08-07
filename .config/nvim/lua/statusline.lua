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

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "kanagawa",
    component_separators = { left = "𐏓", right = "𐏓" },
    section_separators = {},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    -- {
    -- 		'diagnostics',
    -- 		sources = { 'nvim_lsp'},
    --
    -- 		-- Displays diagnostics for the defined severity types
    -- 		sections = { 'error', 'warn', 'info', 'hint' },
    --
    -- 		diagnostics_color = {
    -- 			-- Same values as the general color option can be used here.
    -- 			error = 'DiagnosticError', -- Changes diagnostics' error color.
    -- 			warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
    -- 			info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
    -- 			hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
    -- 		},
    -- 		symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
    -- 		colored = true,           -- Displays diagnostics status in color if set to true.
    -- 		update_in_insert = false, -- Update diagnostics in insert mode.
    -- 		always_visible = false,   -- Show diagnostics even if there are none.
    -- 	}
    -- },
    lualine_b = {
      { "branch", icon = "" },
      "diff",
      { "diagnostics", icons_enabled = false, sources = { "nvim_diagnostic" } },
    },
    lualine_c = { "filename" },
    lualine_x = { lsp_name },
    lualine_y = { "filetype" },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
