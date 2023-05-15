return {
  "folke/todo-comments.nvim",
  cmd = {
    "TodoTrouble",
    "TodoTelescope",
    "TodoLocList",
    "TodoQuickFix"
  },
  keys = {
    { "<leader>tq", [[<cmd>TodoQuickFix theme=ivy<CR>]], { silent = true, desc = "Todo Quick Fix" } }
  },
  config = true,
}
