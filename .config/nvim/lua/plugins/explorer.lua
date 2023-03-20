-- live grep using Telescope inside the current directory under
-- the cursor (or the parent directory of the current file)
local function grep_in(node)
  if not node then
    return
  end
  local path = node.absolute_path or uv.cwd()
  if node.type ~= 'directory' and node.parent then
    path = node.parent.absolute_path
  end
  require('telescope.builtin').live_grep({
    search_dirs = { path },
    prompt_title = string.format('Grep in [%s]', vim.fs.basename(path)),
  })
end
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {

    { "<C-b>", "<CMD>NvimTreeFindFileToggle<CR>", mode = { "n", "i", "v" } },
    { '<C-f>', grep_in },
  },
  opts = {
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
  }
}
