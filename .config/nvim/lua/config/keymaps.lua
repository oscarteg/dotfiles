-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use 'mm' to run :make
vim.api.nvim_set_keymap("n", "mm", ":make<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "mm", ":make<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "mm", ":make<CR>", { noremap = true, silent = true })

-- Remove moving of Lines because it's buggy when typing fast
vim.api.nvim_set_keymap("n", "<A-j>", "<Nop>", { desc = "Nothing" })
vim.api.nvim_set_keymap("n", "<A-k>", "<Nop>", { desc = "Nothing" })
vim.api.nvim_set_keymap("i", "<A-j>", "<Nop>", { desc = "Nothing" })
vim.api.nvim_set_keymap("i", "<A-k>", "<Nop>", { desc = "Nothing" })
vim.api.nvim_set_keymap("v", "<A-j>", "<Nop>", { desc = "Nothing" })
vim.api.nvim_set_keymap("v", "<A-k>", "<Nop>", { desc = "Nothing" })

vim.api.nvim_set_keymap("n", "<C-/>", "<Nop>", { desc = "Nothing" })
vim.api.nvim_set_keymap("i", "<C-/>", "<Nop>", { desc = "Nothing" })

--  Search and replace the current word under the cursor
vim.api.nvim_set_keymap(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { noremap = true, silent = true, desc = "Search and replace current word in buffer" }
)

-- Run the current typescript file with bun
vim.api.nvim_set_keymap("n", "<leader>xf", ":compiler bun<CR>:make<CR>", { noremap = true, silent = true })
