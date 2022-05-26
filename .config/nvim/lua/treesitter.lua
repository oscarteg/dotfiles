require("nvim-treesitter.configs").setup({
	ensure_installed= { "rust", "typescript", "go", "zig"},
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
