return {
  'folke/twilight.nvim',
  cmd = 'Twilight',
  config = function()
    require("twilight").setup({
      treesitter = true,
    })
  end,
  keys = {
    { "<leader>tt", "<CMD>Twilight<CR>", { silent = true } }
  }
}
