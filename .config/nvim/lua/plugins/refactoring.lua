return {
  'ThePrimeagen/refactoring.nvim',
  config = true,
  keys = {
    {
      "<leader>re",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
      { noremap = true, silent = true, expr = false, mode = "v" }
    },
    {
      "<leader>rf",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
      { noremap = true, silent = true, expr = false, mode = "v" }
    },
    {
      "<leader>rv",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
      { noremap = true, silent = true, expr = false, mode = "v" }
    },
    {
      "<leader>ri",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
      { noremap = true, silent = true, expr = false, "v" }
    },

    {
      "<leader>rb",
      [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
      { noremap = true, silent = true, expr = false, mode = "n" }
    },
    {
      "<leader>rbf",
      [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
      { noremap = true, silent = true, expr = false, mode = "n" }
    },

    {
      "<leader>ri",
      [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
      { noremap = true, silent = true, expr = false, mode = "n" }
    }
  }
}
