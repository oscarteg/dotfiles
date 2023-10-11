local g = vim.g

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end


vim.keymap.set("n", "mm", "<cmd>make<cr>", { silent = true })
-- Remap space as leader key
map("n", "<space>", "", { silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- save without formatting
map("n", "<leader>w", ":noa w<cr>")
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-- buffers
map("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })

-- Moving lines up/down in V mode
-- map("n", "<A-j>", ":m .+1<CR>==")
-- map("n", "<A-k>", ":m .-2<CR>==")
-- map("v", "<A-j>", ":m '>+1<CR>gv=gv")
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- Combine next line and cursor place holds
map("n", "J", "mzJ`z")

-- Paste without adding to register
map("x", "<leader>p", [["_dP]])

-- Buffer
map("n", "<leader>/", "<cmd>noh<CR>")

-- Tabs
map("n", "tn", ":tabnew<CR>")
map("n", "tk", ":tabnext<CR>")
map("n", "tj", ":tabprev<CR>")

-- Have j and k navigate visual lines rather than logical ones
map("n", "j", "gj")
map("n", "k", "gk")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { silent = true })
map("n", "<C-Down>", ":resize +2<CR>", { silent = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Dont put in registere when pasting over something
map("v", "p", '"_dp', { silent = true })

-- vim-fugitive (<leader>v mappings)
map("n", "<leader>vs", "<cmd>G<CR>")
map("n", "<leader>vg", "<cmd>diffget //1<CR>") -- working copy
map("n", "<leader>vf", "<cmd>diffget //2<CR>") -- current branch / HEAD
map("n", "<leader>vj", "<cmd>diffget //3<CR>") -- merge branch

map("t", "<Esc>", "<C-\\><C-n>")

-- Quickfix
map("n", "<leader>Q", ":cclose<cr>")
map("n", "<leader>q", ":botright copen<cr>")
map("n", "<C-H>", ":cp<cr>")
map("n", "<C-L>", ":cn<cr>")
