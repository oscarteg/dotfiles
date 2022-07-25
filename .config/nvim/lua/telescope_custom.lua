local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    color_devicons = false,
    file_ignore_patterns = { "node_modules", ".git", "build", "dist" },
    dynamic_preview_title = true,
    mappings = {
      i = {
        ["<C-l"] = actions.close,
      },
    },
  },

  pickers = {
    find_files = {
      theme = "dropdown",
      hidden = true,
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

require("telescope").load_extension("ui-select")
