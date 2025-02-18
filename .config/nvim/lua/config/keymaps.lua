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
vim.keymap.set("n", "gV", function()
  vim.cmd("normal! m'")
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end)

--  Search and replace the current word under the cursor
vim.api.nvim_set_keymap(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { noremap = true, silent = true, desc = "Search and replace current word in buffer" }
)

-- Function to remove comments
local function remove_comments()
  -- Ensure we have a parser for the current buffer
  local parser = vim.treesitter.get_parser(0)
  if not parser then
    print("No treesitter parser available for this buffer")
    return
  end

  -- Parse the buffer
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Get all comment nodes
  local query = vim.treesitter.query.parse(
    vim.bo.filetype,
    [[
    (comment) @comment
  ]]
  )

  -- Collect all comment ranges
  local ranges = {}
  for id, node in query:iter_captures(root, 0, 0, -1) do
    local start_row, start_col, end_row, end_col = node:range()
    table.insert(ranges, { start_row, start_col, end_row, end_col })
  end

  -- Sort ranges in reverse order (to avoid shifting issues when deleting)
  table.sort(ranges, function(a, b)
    return a[1] > b[1] or (a[1] == b[1] and a[2] > b[2])
  end)

  -- Delete the ranges
  for _, range in ipairs(ranges) do
    vim.api.nvim_buf_set_text(0, range[1], range[2], range[3], range[4], {})
  end
end

-- Create the command
vim.api.nvim_create_user_command("RemoveComments", remove_comments, {})
