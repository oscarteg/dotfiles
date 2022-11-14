local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    color_devicons = false,
    file_ignore_patterns = { "node_modules", ".git", "build", "dist" },
    dynamic_preview_title = true,
  },
  pickers = {
    find_files = {
      theme = "ivy",
      hidden = true,
        find_command = {
          'fd',
          '--type',
          'file',
          '--type',
          'symlink',
          '--hidden',
          '--exclude',
          '.git',
        }
    },
    live_grep = {
      theme = "ivy",
      hidden = true,
      additional_args = function()
        return { "--hidden" }
      end
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
  },
})

require("telescope").load_extension("ui-select")
