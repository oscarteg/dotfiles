local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local o = vim.o
local g = vim.g

-- Enable mouse in all modes
opt.background = "dark"
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.ignorecase = true
opt.smartcase = true
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
opt.undofile = true

api.nvim_set_option("guifont", "Dank Mono:h22")

-- code indention
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
o.splitright = true
-- omnifunc completion
o.completeopt = "menu,noinsert,noselect"

-- statusline
-- don't show useless messages from completion
opt.shortmess:prepend("c")

-- ripgrep
o.grepprg = [[rg --no-heading --smart-case --vimgrep ]]
o.grepformat = "%f:%l:%c:%m"

-- neovide
o.guifont = "Dank Mono:h20"

api.nvim_command "colorscheme gruber"

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
