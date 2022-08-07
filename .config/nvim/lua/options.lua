local opt = vim.opt
local cmd = vim.cmd
local api = vim.api

-- Enable mouse in all modes
opt.background = "dark"
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.ignorecase = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.cursorline = true
opt.hidden = true
-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
opt.updatetime = 300
opt.splitright = true
opt.nrformats:remove("octal")
opt.scrolloff = 999
opt.path:prepend("**")
opt.swapfile = false
opt.list = true
opt.listchars = "tab:→ ,extends:»,precedes:«,nbsp:␣,trail:•"
api.nvim_set_option("guifont", "Dank Mono:h22")

-- code indention
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- omnifunc completion
vim.o.completeopt = "menu,noinsert,noselect"

-- statusline
-- don't show useless messages from completion
opt.shortmess:prepend("c")

-- grep
vim.o.grepprg = [[rg --no-heading --smart-case --vimgrep ]]
vim.o.grepformat = "%f:%l:%c:%m"

vim.g.catppuccin_flavour = "mocha"

-- Neovide
vim.o.guifont = "Dank Mono:h20"

cmd("colorscheme kanagawa")
