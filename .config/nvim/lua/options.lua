local opt = vim.opt
local api = vim.api
local o = vim.o

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
o.wildmode = 'full'
-- opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"

-- Split vertical below
o.splitbelow = true

-- code indention
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.splitright = true

-- Set colrscheme
api.nvim_command("colorscheme gruber")

-- mdx
api.nvim_create_autocmd("BufRead,BufEnter", { pattern = "*.mdx", command = [[set filetype=mdx]] })
-- astro
api.nvim_create_autocmd("BufRead,BufEnter", { pattern = "*.astro", command = [[set filetype=astro]] })

-- set compiler to bun when typescript file
api.nvim_create_autocmd("BufRead,BufEnter", { pattern = { "*.ts", "*.js" }, command = [[compiler bun]] })

-- highlight text on yank
api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

-- make test commands execute using neovim terminal
vim.g["test#strategy"] = "neovim"


-- Sync format when saving and exiting the buffer
-- https://github.com/lukas-reineke/lsp-format.nvim#wq-will-not-format-when-not-using-sync
vim.cmd("cabbrev wq execute \"Format sync\" <bar> wq")
