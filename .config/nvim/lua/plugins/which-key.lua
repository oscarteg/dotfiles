return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local wk = require("which-key")
		wk.setup({
			plugins = { spelling = true },
			key_labels = { ["<leader>"] = "SPC" },
		})
		wk.register({
			mode = { "n", "v" },
			["g"] = { name = "+goto" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["<leader>d"] = { name = "[D]ebug" },
			["<leader><tab>"] = { name = "+tabs" },
			["<leader>b"] = { name = "[B]uffer" },
			["<leader>c"] = { name = "[C]ode" },
			["<leader>f"] = { name = "[F]ind/[F]ile" },
			["<leader>g"] = { name = "+git" },
			["<leader>gh"] = { name = "+hunks" },
			["<leader>r"] = { name = "[R]efactoring" },
			["<leader>s"] = { name = "[S]earch" },
			["<leader>t"] = { name = "[T]est" },
			["<leader>p"] = { name = "[P]ersistence" },
			["<leader>w"] = { name = "+windows+workspace" },
			["<leader>x"] = { name = "+diagnostics/quickfix" },
		})
	end,
}
