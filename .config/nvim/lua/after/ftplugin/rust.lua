vim.cmd [[compiler cargo]]

print("in rust file")
vim.keymap.set("n", "m<CR>", print("testing"))
