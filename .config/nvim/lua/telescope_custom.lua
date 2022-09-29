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
      theme = "ivy",
      hidden = true,
    },
    live_grep = {
      theme = "ivy",
      hidden = true,
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
  },
})

require("telescope").load_extension("ui-select")
