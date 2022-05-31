local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		dynamic_preview_title = true,
	},

  pickers = {
    find_files = {
      theme = "dropdown"
    }
  },

	extensions = {
		["ui-select"] = {
		require("telescope.themes").get_dropdown { }
		}
	}
})

require("telescope").load_extension("ui-select")
