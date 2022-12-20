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
api.nvim_create_autocmd("Filetype", { pattern = { "*.ts", "*.js" }, command = [[compiler bun]] })
api.nvim_create_autocmd("BufEnter", { pattern = "*.ts", command = [[let b:dispatch = 'bun %']] })

-- highlight text on yank
api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})
