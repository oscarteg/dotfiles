local g = vim.g
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })

	print "Installing packer.nvim. Restart Neovim"
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use "savq/paq-nvim"
	use "Domeee/mosel.nvim"
	use "tpope/vim-fugitive"
	use "tpope/vim-surround"
	use "HerringtonDarkholme/yats.vim"
	use "rbgrouleff/bclose.vim"
	use "neovim/nvim-lspconfig"
	use "nvim-lua/plenary.nvim"
	use "nvim-telescope/telescope.nvim"
	use 'nvim-telescope/telescope-ui-select.nvim'
	use "kyazdani42/nvim-web-devicons"
	use 'numToStr/Comment.nvim' 
	-- completion
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-vsnip"
	use "hrsh7th/vim-vsnip"
	-- completion end
	use "nvim-lualine/lualine.nvim"
	use { 
		"nvim-treesitter/nvim-treesitter", 
		run = ":TSUpdate" 
	}
	use "nvim-treesitter/playground"
	use "windwp/nvim-ts-autotag"
	use "numToStr/Comment.nvim"
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use {
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	}
	use "norcalli/nvim-colorizer.lua"
	-- Rust
	use 'rust-lang/rust.vim'
	use 'simrat39/rust-tools.nvim'

	-- Go
	use 'crispgm/nvim-go'

	-- Zig
	use 'ziglang/zig.vim'

	if packer_bootstrap then
		require("packer").sync()
	end
end)



-- customization
-- g.vsnip_snippet_dir = vim.fn.expand("~/.config/vsnip")