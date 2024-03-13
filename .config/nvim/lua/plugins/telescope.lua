local utils = require("utils")
local telescope_builtin = require("telescope.builtin")

local config = function()
	local telescope = require("telescope")
	local lga_actions = require("telescope-live-grep-args.actions")

	-- Flash.nvim
	-- https://github.com/folke/flash.nvim
	-- This will allow you to use s in normal mode and <c-s> in insert mode, to jump to a label in Telescope results.
	local function flash(prompt_bufnr)
		require("flash").jump({
			pattern = "^",
			label = { after = { 0, 0 } },
			search = {
				mode = "search",
				exclude = {
					function(win)
						return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
					end,
				},
			},
			action = function(match)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				picker:set_selection(match.pos[1] - 1)
			end,
		})
	end
	telescope.defaults = vim.tbl_deep_extend("force", telescope.defaults or {}, {
		mappings = {
			n = { s = flash },
			i = { ["<c-s>"] = flash },
		},
	})

	telescope.setup({
		defaults = {
			color_devicons = false,
			file_ignore_patterns = { "node_modules", ".git", "build", "dist" },
			dynamic_preview_title = true,
			path_display = {
				truncate = 3,
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_cursor({}),
			},
			file_browser = {
				hidden = true,
			},
			live_grep_args = {
				auto_quoting = true,
				mappings = {
					-- extend mappings
					i = {
						["<C-k>"] = lga_actions.quote_prompt(),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					},
				},
			},
		},
	})
	require("telescope").load_extension("ui-select")
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("live_grep_args")
end

return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>ff", utils.telescope("find_files", { cwd = false }),     desc = "[F]ind [F]iles (root dir)" },
			{ "<leader>fF", utils.telescope("find_files"),                      desc = "[F]ind [F]iles (cwd)" },
			{ "<leader>fg", utils.telescope("live_grep", { cwd = false }),      desc = "[F]ind [G]rep (root dir)" },
			{ "<leader>fG", utils.telescope("live_grep"),                       desc = "[F]ind [G]rep (cwd)" },
			{ "<leader>fb", telescope_builtin.file_browser,                     desc = "" },
			{ "<leader>fB", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "[F]ind [B]uffer" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>",                      desc = "[F]ind [R]ecent" },
			{ "<leader>fs", "<cmd>Telescope git_status<CR>",                    desc = "[F]ind [S]tatus" },
			{ "<leader>fc", "<cmd>Telescope git_commits<CR>",                   desc = "[F]ind [C]ommits" },
			{
				"<leader>fd",
				utils.telescope("diagnostics"),
				desc = "[F]ind [D]iagnostics",
			},
			{
				"<leader>fw",
				utils.telescope("grep_string"),
				desc = "[F]ind current [W]ord",
			},
			{
				"<leader>ss",
				utils.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				config = function()
					require("telescope").load_extension("fzf")
				end,
				build =
				"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},

			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
			},
		},
		cmd = "Telescope",
		config = config,
	},
}
