local on_attach = function(client, bufnr, lsp)
  lsp.default_keymaps({ buffer = bufnr, })

  lsp.buffer_autoformat()

  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {
    desc = "[G]oto [R]eferences",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>gt", require("telescope.builtin").lsp_type_definitions, {
    desc = "[G]oto [T]ype definition",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, {
    desc = "[D]ocument [S]ymbols",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, {
    desc = "[W]orkspace [S]ymbols",
    buffer = bufnr,
  })

  vim.keymap.set("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>", {
    desc = "[G]oto definition [V]ertical",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", buffer = bufnr })

  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Show function signature", buffer = bufnr })

  vim.keymap.set(
    "n", "ca",
    vim.lsp.buf.code_action,
    { desc = "[C]ode [A]ction", remap = false, buffer = bufnr }
  )

  vim.keymap.set({ 'n', 'x' }, 'gq', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end)
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      require('lsp-zero.settings').preset("recommended")
    end
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',

        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "petertriho/cmp-git" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      require('lsp-zero.cmp').extend({
        set_extra_mappings = true
      })

      local cmp = require("cmp")
      local cmp_action = require('lsp-zero.cmp').action()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = 'luasnip', keyword_length = 2 },
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'buffer',  keyword_length = 3 },
          { name = "nvim_lua" },
        }, {
          name = 'buffer'
        }),
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),

          -- Trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          -- Navigate between placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })



      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }

        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline', max_item_count = 5 }
        })
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            -- require("snippets.typescript")
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'simrat39/rust-tools.nvim' },
      { 'jose-elias-alvarez/typescript.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      {
        "ray-x/go.nvim",
        dependencies = {
          "neovim/nvim-lspconfig",
          "ray-x/guihua.lua",
          "nvim-treesitter/nvim-treesitter",
        },
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
      },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      local lsp = require("lsp-zero").preset("recommended")
      local lspconfig = require('lspconfig')

      lsp.on_attach(function(client, bufnr)
        on_attach(client, bufnr, lsp)
      end)

      lsp.set_sign_icons({
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
      })

      lsp.skip_server_setup({
        "rust_analyzer",
        "tsserver",
      })

      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())


      lspconfig.denols.setup {
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      }


      lsp.setup()

      vim.diagnostic.config({
        virtual_text = {
          prefix = "",
        }
      })

      local ts = require("typescript")


      lspconfig.tsserver.setup {
      }
      ts.setup({
        server = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
            noInferredTypeTruncation = true
          },
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
          on_attach = function(client, bufnr)
            require("twoslash-queries").attach(client, bufnr)
            vim.keymap.set('n', '<leader>ci', '<cmd>TypescriptAddMissingImports<cr>',
              { buffer = bufnr, desc = "Add missing imports", silent = true })
            vim.keymap.set('n', '<leader>co', '<cmd>TypescriptOrganizeImports<cr>',
              { buffer = bufnr, desc = "Organize imports" })
            vim.keymap.set('n', '<leader>cf', '<cmd>TypescriptFixAll<cr>', { buffer = bufnr, desc = "Fix all" })
            vim.keymap.set('n', '<leader>cu', '<cmd>TypescriptRemoveUnused<cr>',
              { buffer = bufnr, desc = "Remove unused" })

            vim.keymap.set("n", "<leader>gD", "<cmd>TypescriptGoToSourceDefinition<CR>", {
              desc = "[G]oto [D]efinition with tsserver",
              buffer = bufnr,
            })

            vim.keymap.set("n", "gV", ":vsplit | :TypescriptGoToSourceDefinition<CR>", {
              desc = "[G]oto definition [V]ertical",
              buffer = bufnr,
            })
          end
        }
      })

      local rust_tools = require('rust-tools')

      rust_tools.setup({
        tools = { inlay_hints = { show_parameter_hints = false } },
        server = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                extraArgs = { "--all", "--", "-W", "clippy::all" },
                command = "clippy"
              }
            }
          },

          on_attach = function(client, bufnr)
            on_attach(client, bufnr, lsp)

            vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions,
              { buffer = bufnr, desc = "Show hover actions" })

            vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })

            vim.keymap.set("n", "J", rust_tools.join_lines.join_lines, { buffer = bufnr, desc = "Join lines" })
          end,
        },
      })

      local go_lang = require("go")

      go_lang.setup({
        lsp_cfg = true,
        lsp_on_attach = function(client, bufnr)
          on_attach(client, bufnr, lsp)
          local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
              require('go.format').goimport()
            end,
            group = format_sync_grp,
          })
        end,
      })

      -- Null LS
      local null_opts = lsp.build_options("null-ls", {})
      local null_ls = require("null-ls")

      null_ls.setup({
        on_attach = function(client, bufnr)
          null_opts.on_attach(client, bufnr)
        end,
        sources = {
          null_ls.builtins.diagnostics.php,
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.cmake_lint,
          null_ls.builtins.diagnostics.buf,
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.formatting.prismaFmt,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.cmake_format,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.elm_format,
          require("typescript.extensions.null-ls.code-actions"),
        },
      })
    end
  }

}
