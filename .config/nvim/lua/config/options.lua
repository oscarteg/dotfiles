-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.conceallevel = 0

-- Register the language
vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})

-- To configure LazyVim to always use the current working directory as the root_dir,
-- set vim.g.root_spec = { "cwd" } in your lua/config/options.lua file,
-- overriding the default behavior of using the LSP server's root_dir.
-- https://github.com/LazyVim/LazyVim/discussions/2150#discussioncomment-7787591
vim.g.root_spec = { "cwd" }

-- Disable swap files
opt.swapfile = false
opt.wrap = true

vim.o.background = "dark"

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = true

-- Disable animations - https://arc.net/l/quote/bklemqco
vim.g.snacks_animate = false
