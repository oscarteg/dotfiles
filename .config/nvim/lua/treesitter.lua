require("nvim-treesitter.configs").setup({
	ensure_installed= { 
    "rust", 
    "typescript", 
    "go", 
    "zig", 
    "graphql", 
    "kotlin", 
    "html", 
    "css", 
    "php", 
    "tsx", 
    "javascript", 
    "typescript", 
    "svelte", 
    "vue", 
    "scss",
    "css",
    "fish",
    "v"
 },
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
