local g = vim.g
local ls = require("luasnip")

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

--Remap space as leader key
map("n", "<space>", "", { silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- return to normal mode
map("v", "<C-l>", "<esc>")
map("c", "<C-l>", "<C-c>")
map("i", "<C-l>", "pumvisible() ? '<C-e>' : '<esc>'", { expr = true })

map("n", "<leader>w", ":w<cr>")
map("n", "<C-space>", "/")
map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)

-- Moving lines up/down in V mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Combine next line and cursor place holds
map("n", "J", "mzJ`z")

-- Stay in the middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Paste without adding to register
map("x", "<leader>p", [["_dP]])

-- Replace word that you are on
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Buffer
map("n", "<leader>/", "<cmd>noh<CR>")
map("n", "<leader>w", "<cmd>update<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>r", "<cmd>make<CR>")
map("n", "<leader>bD", "<cmd>%bdelete<CR>")

-- Tabs
map("n", "tn", ":tabnew<CR>")
map("n", "tk", ":tabnext<CR>")
map("n", "tj", ":tabprev<CR>")

-- navigation
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

-- Have j and k navigate visual lines rather than logical ones
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<leader>j", ",")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { silent = true })
map("n", "<C-Down>", ":resize +2<CR>", { silent = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- run tests in current file
map("n", "<leader>T", [[<cmd>:TestFile -strategy=dispatch<CR>]], { silent = true })

-- Move text up and down
map("v", "<A-j>", ":m +1<CR>==", { silent = true })
map("v", "<A-k>", ":m -1<CR>==", { silent = true })

-- Dont put in registere when pasting over something
map("v", "p", '"_dp', { silent = true })

-- Move text up and down
map("v", "<A-j>", ":m +1<CR>==", { silent = true })
map("v", "<A-k>", ":m -1<CR>==", { silent = true })
map("v", "p", '"_dp', { silent = true })

-- explorer
map("n", "<C-b>", [[<cmd>NvimTreeFindFileToggle<CR>]], {silent = true})

-- vim-fugitive (<leader>v mappings)
map("n", "<leader>vs", "<cmd>G<CR>")
map("n", "<leader>vg", "<cmd>diffget //1<CR>") -- working copy
map("n", "<leader>vf", "<cmd>diffget //2<CR>") -- current branch / HEAD
map("n", "<leader>vj", "<cmd>diffget //3<CR>") -- merge branch

-- Vim test (<leader>t mappings)
map("n", "<leader>tn", "<CMD>TestNearest<cr>", { silent = true })
map("n", "<leader>tf", "<CMD>TestFile<cr>", { silent = true })
map("n", "<leader>ts", "<CMD>TestSuite<cr>", { silent = true })
map("n", "<leader>tl", "<CMD>TestLast<cr>", { silent = true })
map("n", "<leader>tv", "<CMD>TestVisit<cr>", { silent = true })
-- TodoTelescope
map("n", "<leader>tf", [[<cmd>TodoTelescope<CR>]], {silent = true})
map("n", "<leader>td", [[<cmd>TodoQuickFix<CR>]], { silent = true })
-- Twilight
map("n", "<leader>tt", "<CMD>Twilight<CR>", { silent = true })

-- Telescope (<leader>f mappings)
map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind [G]rep' })
map('n', '<leader>fs', require('telescope.builtin').git_status, { desc = '[F]ind [G]it status' })
map('n', '<leader>fh', require('telescope.builtin').oldfiles, { desc = '[F]ind [H]istory' })
map('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers' })
map('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
map('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

-- UndotreeToggle
map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Harpoon
map("n", "<leader>m", require("harpoon.mark").add_file)
map("n", "<leader>fm", "<CMD>Telescope harpoon marks<cr>")

-- ThePrimeagen/refactoring
map("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

-- Extract block doesn't need visual mode
map("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
map("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
map("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
