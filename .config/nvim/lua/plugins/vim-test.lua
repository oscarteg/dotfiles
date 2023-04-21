return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tn", "<CMD>TestNearest<cr>" },
      { "<leader>tf", "<CMD>TestFile<cr>",   { description = "Test the current file" } },
      { "<leader>tk", "<CMD>TestSuite<cr>" },
      { "<leader>tl", "<CMD>TestLast<cr>" },
      { "<leader>tv", "<CMD>TestVisit<cr>" },
    },
    config = function()
      vim.g["test#strategy"] = "dispatch"
    end
  }, -- Quick testing

}
