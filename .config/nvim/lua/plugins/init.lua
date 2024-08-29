-- since this is just an example spec, don't actually load anything here and return an empty spec
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- colorschemes
  { "nyoom-engineering/oxocarbon.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum",
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {

    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
  },
  { "catppuccin/nvim", enabled = false },
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "deep ocean"
    end,
    opts = {
      plugins = {
        "dap",
        "flash",
        "gitsigns",
        "mini",
        "neo-tree",
        "nvim-notify",
        "nvim-tree",
        "neotest",
        "trouble",
        "telescope",
        "which-key",
      },
      -- lualine_style = "stealth",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rosebones",
    },
  },

  -- change trouble configinit
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols.get,
        cond = symbols.has,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local open_with_trouble = require("trouble.sources.telescope").open
      return {
        -- Open all pickers with the ivy theme
        defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
          mappings = {
            n = {
              ["<M-q>"] = open_with_trouble,
            },
            i = {
              ["<M-q>"] = open_with_trouble,
            },
          },
        }),

        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = { "--hidden" },
          },
        },
      }
    end,
  },

  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.editor.dial" },
  { import = "lazyvim.plugins.extras.editor.harpoon2" },
  { import = "lazyvim.plugins.extras.editor.inc-rename" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.lang.astro" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.cmake" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.elixir" },
  { import = "lazyvim.plugins.extras.lang.gleam" },
  { import = "lazyvim.plugins.extras.lang.go" },
  -- { import = "lazyvim.plugins.extras.lang.haskell" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.json" },

  { import = "lazyvim.plugins.extras.lang.nix" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.scala" },
  { import = "lazyvim.plugins.extras.lang.svelte" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.lsp.neoconf" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
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

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
      },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>j",
        function()
          require("treesj").toggle()
        end,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    config = true,
    keys = {
      {
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        { noremap = true, silent = true, expr = false, mode = "v" },
      },
      {
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        { noremap = true, silent = true, expr = false, mode = "v" },
      },
      {
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        { noremap = true, silent = true, expr = false, mode = "v" },
      },
      {
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false, "v" },
      },

      {
        "<leader>rb",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        { noremap = true, silent = true, expr = false, mode = "n" },
      },
      {
        "<leader>rbf",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        { noremap = true, silent = true, expr = false, mode = "n" },
      },

      {
        "<leader>ri",
        [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false, mode = "n" },
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undo Tree" } },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim", -- File explorer
    opts = {
      enable_diagnostics = true,
      default_component_configs = {
        git_status = {
          symbols = {
            renamed = "󰁕",
            unstaged = "󰄱",
          },
        },
      },
      window = {
        mappings = {
          ["x"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
      },
      -- Add this section only if you've configured source selector.
      source_selector = {
        winbar = false,
        statusline = true,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      },
      filesystem = {
        enabled = true,
        follow_current_file = {},
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- Navigate between completion items
      opts.mapping["<C-j>"] = cmp.mapping.select_next_item()
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item()

      -- Trigger completion menu
      opts.mapping["<C-Space>"] = cmp.mapping.complete()

      opts.mapping["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    end,
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
        { desc = "[V]ersion [D]iff [F]ile" },
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
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>fs", "<CMD>Scratch<CR>", { desc = "[F]ile [S]cratch" } },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettierd", "prettier" },
        ["javascriptreact"] = { "prettierd", "prettier" },
        ["typescript"] = { "prettierd", "prettier" },
        ["typescriptreact"] = { "prettierd", "prettier" },
        ["vue"] = { "prettierd", "prettier" },
        ["css"] = { "prettierd", "prettier" },
        ["scss"] = { "prettierd", "prettier" },
        ["less"] = { "prettierd", "prettier" },
        ["html"] = { "prettierd", "prettier" },
        ["json"] = { "prettierd", "prettier" },
        ["jsonc"] = { "prettierd", "prettier" },
        ["yaml"] = { "prettierd", "prettier" },
        ["markdown"] = { "prettierd", "prettier" },
        ["markdown.mdx"] = { "prettierd", "prettier" },
        ["graphql"] = { "prettierd", "prettier" },
        ["handlebars"] = { "prettierd", "prettier" },
      },
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
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
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
      { [[<C-\>]] },
      { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
      {
        "<leader>tk",
        "<cmd>ToggleTerm size=40 dir=~/Desktop direction=horizontal<cr>",
        desc = "[T]erminal [K] Horizontal",
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
    init = function()
      require("lspconfig").gleam.setup({})
    end,

    opts = {
      servers = {
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
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<A-l>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      })
    end,
  },

  -- Copilot
  -- { import = "lazyvim.plugins.extras.coding.copilot" },
  -- -- Disable copilot in cmp and use the default cmp completion
  -- -- NOTE: The copilot was to slow and would appear after the LSP completion
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<A-l>",
  --       },
  --     },
  --     panel = { enabled = false },
  --   },
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   enabled = false,
  -- },
  {
    "echasnovski/mini.starter",
    opts = function()
      local pad = string.rep(" ", 22)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end
      local starter = require("mini.starter")
      return {
        evaluate_single = true,
        header = "",
        items = {
          new_section("Find file", "Telescope git_files", "Telescope"),
          new_section("Recent files", "Telescope oldfiles", "Telescope"),
          new_section("Grep text", "Telescope live_grep", "Telescope"),
          new_section("Config", LazyVim.pick.config_files(), "Config"),
          new_section("Lazy", "Lazy", "Config"),
          new_section("New file", "ene | startinsert", "Built-in"),
          new_section("Quit", "qa", "Built-in"),
          new_section("Session restore", [[lua require("persistence").load()]], "Session"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      }
    end,
  },
}
