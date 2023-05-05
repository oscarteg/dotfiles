return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufRead",
  keys = {
    { "zr", function() require("ufo").openAllFolds() end },
    { "zm", function() require("ufo").closeAllFolds() end },
  },
  config = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    require("ufo").setup({
      close_fold_kinds = { "imports" },
    })
  end,
}
