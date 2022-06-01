local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		dynamic_preview_title = true,
    mappings = {
      i = {
        ["<C-l"] = actions.close
      }
    }
	},

  pickers = {
    find_files = {
      theme = "dropdown",
      hidden = true
    },
    grep_string = {
      hidden = true
    }
  },

	extensions = {
		["ui-select"] = {
		require("telescope.themes").get_dropdown { }
		}
	}
})

require("telescope").load_extension("ui-select")
