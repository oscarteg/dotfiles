return {
  'fedepujol/move.nvim',
  keys = {
    { "<A-j>", "<CMD>MoveLine(1)<CR>" },
    { "<A-k>", "<CMD>MoveLine(-1)<CR>" },
    { "<A-h>", "<CMD>MoveLine(-1)<CR>" },
    { "<A-l>", "<CMD>MoveLine(1)<CR>" },

    { "<A-j>", "<CMD>MoveBlock(1)<CR>",  mode = "v" },
    { "<A-k>", "<CMD>MoveBlock(-1)<CR>", mode = "v" },
    { "<A-h>", "<CMD>MoveBlock(-1)<CR>", mode = "v" },
    { "<A-l>", "<CMD>MoveBlock(1)<CR>",  mode = "v" },
  }
}
