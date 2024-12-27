local function find_config(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end

local function biome_or_prettier(bufnr)
  local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })
  if has_biome_config then
    return { "biome", stop_after_first = true }
  end

  local has_prettier_config = find_config(bufnr, {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  })
  if has_prettier_config then
    return { "prettier", stop_after_first = true }
  end

  -- Default to Prettier if no config is found
  return { "prettier", stop_after_first = true }
end

local filetypes_with_dynamic_formatter = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

return {
  -- colorschemes
  { "nyoom-engineering/oxocarbon.nvim" },
  { "bettervim/yugen.nvim" },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.adwaita_darker = true
    end,
  },
  {
    "ccxnu/rosebones",
    lazy = false,
    priority = 1000,
  },
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
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "adwaita",
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

      opts.theme = "adwaita"
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
  { import = "lazyvim.plugins.extras.lang.ocaml" },
  { import = "lazyvim.plugins.extras.ai.supermaven" },
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
        "biome",
        "dockerfile-language-server",
        "elixir-ls",
        "emmet-ls",
        "prettier",
        "prettierd",
        "stylua",
        "svelte-language-server",
        "tailwindcss-language-server",
        "templ",
        "vtsls",
        "zls",
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
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.biome)
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = (function()
        local result = {}
        for _, ft in ipairs(filetypes_with_dynamic_formatter) do
          result[ft] = biome_or_prettier
        end
        return result
      end)(),
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
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
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
        "<cmd>ToggleTerm direction=horizontal<cr>",
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
        eslint = {},
        tsserver = {},
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
}
