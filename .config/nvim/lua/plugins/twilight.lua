local opts = {
}
return {
  'folke/twilight.nvim',
  cmd = 'Twilight',
  config = function()
    require("twilight").setup({
      treesitter = true,
    })
  end,
  keys = {
    { "n", "<leader>tt", "<CMD>Twilight<CR>", { silent = true } }
  }
}
