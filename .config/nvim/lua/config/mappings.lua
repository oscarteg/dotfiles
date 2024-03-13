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

-- save without formatting
map("n", "<leader>w", ":noa w<cr>")
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.open_float, { desc = "Show diagnostic [Q]uickfix list" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- buffers
map("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })

-- Windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

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
