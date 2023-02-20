return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tn", "<CMD>TestNearest<cr>" },
      { "<leader>t",  "<CMD>TestFile<cr>" },
      { "<leader>tk", "<CMD>TestSuite<cr>" },
      { "<leader>tl", "<CMD>TestLast<cr>" },
      { "<leader>tv", "<CMD>TestVisit<cr>" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
    end
  }, -- Quick testing

}
