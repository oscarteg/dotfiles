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

-- Go to definition in a vertical split
vim.api.nvim_set_keymap("n", "gV", ":vsplit | lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

--  Search and replace the current word under the cursor
vim.api.nvim_set_keymap(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { noremap = true, silent = true, desc = "Search and replace current word in buffer" }
)

-- Run the current typescript file with bun
vim.api.nvim_set_keymap("n", "<leader>xf", ":compiler bun<CR>:make<CR>", { noremap = true, silent = true })

-- Function to get the variable under the cursor using Treesitter
function get_variable_under_cursor()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()

  if node == nil then
    return nil
  end

  -- Traverse up the tree to find an identifier node
  while node and node:type() ~= "identifier" do
    node = node:parent()
  end

  if node and node:type() == "identifier" then
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == end_row then
      local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
      return string.sub(line, start_col + 1, end_col)
    end
  end

  return nil
end

-- Function to insert console.log
function insert_console_log()
  local variable = get_variable_under_cursor()
  if variable then
    local log_statement = string.format('console.log("%s:", %s);', variable, variable)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], false, { log_statement })
    vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, 0 })
  else
    print("No variable found under cursor")
  end
end

-- Set up the keymap for supported filetypes
-- TODO: Fix this
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
--   callback = function()
--     vim.api.nvim_buf_set_keymap(
--       0,
--       "n",
--       "<leader>ck",
--       ":lua insert_console_log()<CR>",
--       { noremap = true, silent = true }
--     )
--   end,
-- })
