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
        -- Grep in hidden folders
        return { "--hidden" }
      end
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
    file_browser = {
      hidden = true

    }
  },
})

require("telescope").load_extension("ui-select")
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("file_browser")
