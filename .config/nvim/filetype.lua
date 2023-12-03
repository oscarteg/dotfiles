-- Add MDX filtype
vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
  filename = {},
  pattern = {},
})

vim.filetype.add {
  extension = {
    onyx = "onyx",
  },
  pattern = {
    [".*onyx$"] = "onyx",
  },
}
