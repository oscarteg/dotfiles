return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- require("gruber-darker").setup()
			-- vim.cmd("colorscheme gruber-darker")

			-- local c = require('gruber-darker.palette')
			-- vim.api.nvim_set_hl(0, 'Normal', { bg = c.black:to_string() })
			-- vim.api.nvim_set_hl(0, "Normal", { ctermfg = c.black, ctermbg = c.black })
		end,
	},
	{ "ellisonleao/gruvbox.nvim" },
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("oxocarbon")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- require("kanagawa")
			-- vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
