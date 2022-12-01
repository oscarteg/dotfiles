local g = vim.g
local ls = require("luasnip")

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Remap space as leader key
map("n", "<space>", "", { silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- return to normal mode
map("v", "<C-l>", "<esc>")
map("c", "<C-l>", "<C-c>")
--- Use <C-l> as <esc> in insert mode or end completion when completion menu opened
map("i", "<C-l>", "pumvisible() ? '<C-e>' : '<esc>'", { expr = true })

-- buffer
map("n", "<leader>/", "<cmd>noh<CR>")
map("n", "<leader>w", "<cmd>update<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>r", "<cmd>make<CR>")
map("n", "<leader>bD", "<cmd>%bdelete<CR>")

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

-- Move text up and down
map("v", "<A-j>", ":m +1<CR>==", { silent = true })
map("v", "<A-k>", ":m -1<CR>==", { silent = true })

-- Dont put in registere when pasting over something
map("v", "p", '"_dp', { silent = true })

-- Move text up and down
map("v", "<A-j>", ":m +1<CR>==", { silent = true })
map("v", "<A-k>", ":m -1<CR>==", { silent = true })
map("v", "p", '"_dp', { silent = true })

-- config
map("n", "<leader>cv", "<cmd>edit $MYVIMRC<CR>")
map("n", "<leader>cvs", "<cmd>so $MYVIMRC<CR>")

-- explorer
map("n", "<leader>ff", "<cmd>NvimTreeFindFileToggle<CR>")

-- misc
map("n", "<leader>tf", "<cmd>TodoTelescope<CR>")

-- vim-fugitive
map("n", "<leader>vs", "<cmd>G<CR>")
map("n", "<leader>vg", "<cmd>diffget //1<CR>") -- working copy
map("n", "<leader>vf", "<cmd>diffget //2<CR>") -- current branch / HEAD
map("n", "<leader>vj", "<cmd>diffget //3<CR>") -- merge branch

-- telescope
map("n", "<leader>sf", [[<cmd>lua require('telescope.builtin').find_files() <CR>]])
map("n", "<leader>sg", [[<cmd>lua require('telescope.builtin').live_grep() <CR>]])
map("n", "<leader>sb", [[<cmd>lua require('telescope.builtin').buffers() <CR>]])
map("n", "<leader>gs", [[<cmd>lua require('telescope.builtin').git_status() <CR>]])
map("n", "<leader>fb", [[<cmd>:Telescope file_browser <CR>]])

-- undo breakpoints
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", "!", "!<C-g>u")
map("i", "?", "?<C-g>u")
map("i", "(", "(<C-g>u")
map("i", ")", ")<C-g>u")
map("i", "{", "{<C-g>u")
map("i", "}", "}<C-g>u")
map("i", "[", "[<C-g>u")
map("i", "]", "]<C-g>u")

-- map("i", "<C-j>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'", { expr = true })

-- luasnip
map("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
map("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
map("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })
map("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })


vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

-- Twilight
map("n", "<leader>tt", [[<cmd>Twilight<CR>]], { silent = true })

map("n", "<leader>td", [[<cmd>TodoQuickFix<CR>]], { silent = true })

-- refactoring
-- Remaps for the refactoring operations currently offered by the plugin
map(
  "v",
  "<leader>re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { silent = true, expr = false }
)

map(
  "v",
  "<leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { silent = true, expr = false }
)

map(
  "v",
  "<leader>rv",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { silent = true, expr = false }
)

map(
  "v",
  "<leader>ri",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { silent = true, expr = false }
)

-- Extract block doesn't need visual mode
map(
  "n",
  "<leader>rb",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
  { silent = true, expr = false }
)

map(
  "n",
  "<leader>rbf",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
  { silent = true, expr = false }
)

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
map(
  "n",
  "<leader>ri",
  [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { silent = true, expr = false }
)

-- prompt for a refactor to apply when the remap is triggered
map("v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>", { silent = true, expr = false })


-- resource file
map("v", "<leader>sv", ":luafile $MYVIMRC", { silent = true })
