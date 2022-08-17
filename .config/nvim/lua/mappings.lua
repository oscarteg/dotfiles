local g = vim.g

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
map("n", "<leader>bD", "<cmd>%bdelete<CR>")

map("n", "tn", ":tabnew<CR>")
map("n", "tk", ":tabnext<CR>")
map("n", "tj", ":tabprev<CR>")

-- navigation
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "J", "5j")
map("n", "K", "5k")
map("v", "J", "5j")
map("v", "K", "5k")
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
map("n", "<leader>ff", "<cmd>NvimTreeToggle<CR>")

-- misc
map("n", "gs", "<cmd>Scratch<CR>")
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>tf", "<cmd>TodoTelescope<CR>")

-- vim-fugitive
map("n", "<leader>vs", "<cmd>G<CR>")
map("n", "<leader>vg", "<cmd>diffget //1<CR>") -- working copy
map("n", "<leader>vf", "<cmd>diffget //2<CR>") -- current branch / HEAD
map("n", "<leader>vj", "<cmd>diffget //3<CR>") -- merge branch

-- vim-gitgutter
map("n", "]h", "<cmd>GitGutterNextHunk<CR>")
map("n", "[h", "<cmd>GitGutterPreviousHunk<CR>")

-- zk
map("n", "<leader>zk", "<cmd>ZkNotes <cr>")

-- telescope
map("n", "<leader>sf", "<cmd>Telescope find_files<cr>")
map("n", "<leader>sg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>sb", "<cmd>Telescope buffers<cr>")

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

-- Twilight
map("n", "<leader>tt", "<cmd>Twilight<CR>", { silent = true })
