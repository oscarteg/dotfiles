local opt = vim.opt
local api = vim.api
local o = vim.o
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.rtp:append("/opt/homebrew/opt/fzf")

opt.filetype = "on"
o.background = "dark"
o.mouse = "a"
o.number = true
o.relativenumber = true
o.signcolumn = "yes:1"
o.ignorecase = true
o.smartcase = true
o.clipboard = "unnamedplus"
o.termguicolors = true
o.cursorline = true
o.hidden = true
o.ignorecase = true
o.incsearch = true
o.magic = true
o.splitright = true
o.scrolloff = 999
opt.path:prepend("**")
o.swapfile = false
o.list = true
o.listchars = "tab:→ ,extends:»,precedes:«,nbsp:␣,trail:•"
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.updatetime = 250
o.writebackup = false
o.wildmenu = true
o.wildmode = "full"
opt.cmdheight = 0

-- Folding with Treesitter
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

-- Treesitter commentstring
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true

-- Split vertical below
o.splitbelow = true

-- code indention
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.splitright = true

-- highlight text on yank
api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
	end,
})

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local signs = {
	Error = "✘",
	Warn = "▲",
	Hint = "⚑",
	Info = "»",
}

-- DiagnosticSigns
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
