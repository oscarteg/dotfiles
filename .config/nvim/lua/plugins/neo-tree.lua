-- file explorer
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>b",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("utils").get_root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    { "<C-b>", "<cmd>Neotree toggle<CR>", desc = "NeoTree (cwd)" },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
  end,
  opts = {
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git"
        }
      }
    }
  },
}
