return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        keymap = {
          accept = "<A-l>",
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    config = function(_, opts)
      require("codecompanion").setup({
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
  },
  {
    "azorng/goose.nvim",
    cmd = { "Goose" },
    opts = {
      default_global_keymaps = false,
      providers = {
        "anthropic",
      },
    },
    keys = {
      {
        "<leader>go",
        "<cmd>Goose<cr>",
        desc = "Goose AI Assistant",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
        },
      },
    },
  },
}
