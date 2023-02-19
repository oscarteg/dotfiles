return {
  {
    "vim-test/vim-test",
    keys = {
      "<leader>tn", -- Run nearest test
      "<leader>tf", -- Run test files
      "<leader>ts", -- Run test suite
      "<leader>tl", -- Run last test
      "<leader>tv", -- Run all tests
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
    end
  }, -- Quick testing

}
