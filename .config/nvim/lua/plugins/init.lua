return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "lackluster-mint",
    },
  },
  -- https://github.com/LazyVim/LazyVim/issues/6039#issuecomment-2856227817
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
      end,
      update_interval = 3000,
      fallback = "dark",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      theme = "lackluster",
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "cmake",
        "css",
        "cpp",
        "clojure",
        "gleam",
        "heex",
        "scss",
        "ron",
        "swift",
        "yaml",
        "svelte",
        "templ",
        "scala",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "query",
        "regex",
        "rust",
        "tsx",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "zig",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "astro-language-server",
        "biome",
        "clangd",
        "cmakelang",
        "cmakelint",
        "codelldb",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "elixir-ls",
        "elixir-ls",
        "emmet-ls",
        "emmet-ls",
        "eslint-lsp",
        "gofumpt",
        "goimports",
        "gopls",
        "hadolint",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "neocmakelsp",
        "nil",
        "prettier",
        "prettierd",
        "rust-analyzer",
        "shfmt",
        "stylua",
        "svelte-language-server",
        "tailwindcss-language-server",
        "taplo",
        "templ",
        "terraform-ls",
        "tflint",
        "vtsls",
        "vue-language-server",
        "yaml-language-server",
        "zls",
      },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>js",
        function()
          require("treesj").split()
        end,
        desc = "Split code block",
      },
      {
        "<leader>jj",
        function()
          require("treesj").join()
        end,
        desc = "Join code block",
      },
      {
        "<leader>jt",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle split/join",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undo Tree" } },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- https://github.com/LazyVim/LazyVim/discussions/5041
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>vdf",
        "<CMD>DiffviewFileHistory %<CR>",
        { desc = "[V]ersion [D]iff [F]ile" },
      },

      {
        "<leader>vdc",
        "<CMD>DiffviewClose<CR>",
        { desc = "[V]ersion [D]iff [C]lose" },
      },
      {
        "<leader>vdo",
        "<CMD>DiffviewOpen<CR>",
        { desc = "[V]ersion [D]iff [O]pen" },
      },
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "G",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
      "Gsplit",
      "Gvsplit",
      "Gtabedit",
    },
  },
  { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        "neotest-plenary",
        "neotest-vitest",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        direction = "vertical",
        shade_terminals = false,

        width = 300,
      })
    end,
    keys = {
      { [[<C-\>]], { desc = "Toggle Terminal" } },
      {
        "<leader>th",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        desc = "[T]erminal [H]orizontal",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {

      { "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" } },
    },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "marilari88/twoslash-queries.nvim",
    },
    opts = {
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
      servers = {
        tailwindCSS = {
          experimental = {
            -- Needed for https://cva.style/docs
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              hints = {
                parameterNames = false,
              },
            },
          },
        },

        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          on_attach = function(client, bufnr)
            require("twoslash-queries").attach(client, bufnr)
          end,
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      -- Remove the "deleted lines" notifications
      table.insert(opts.routes, {
        filter = {
          event = "msg_show",
          kind = "", -- or `kind = ""`
        },
        opts = {
          skip = true,
        },
      })
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      -- or if using `mini.icons`
      -- { "echasnovski/mini.icons" },
    },
    keys = {
      {
        ";",
        function()
          require("arrow").toggle_quick_menu()
        end,
        desc = "Open Arrow",
      },
    },
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      separate_by_branch = true,
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sf",
        function()
          local grug = require("grug-far")
          grug.open({
            prefills = { paths = vim.fn.expand("%") },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace current file",
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = {
        "builtin",
        "user.run_script",
        "user.cpp_build",
      },
    },
  },
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
    config = function()
      require("goose").setup({})
    end,
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
