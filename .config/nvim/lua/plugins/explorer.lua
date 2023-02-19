return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  keys = {
    { "<C-b>", "<CMD>Neotree toggle<CR>", mode = { "n", "i", "v" } }
  },
  config = true,
}
