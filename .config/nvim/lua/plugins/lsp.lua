local on_attach = function(client, bufnr)
  local lsp = require("lsp-zero").preset("recommended")
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()

  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {
    desc = "[G]oto [R]eferences",
    remap = false,
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>gt", require("telescope.builtin").lsp_type_definitions, {
    desc = "[G]oto [T]ype definition",
    remap = false,
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, {
    desc = "[D]ocument [S]ymbols",
    remap = false,
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, {
    desc = "[W]orkspace [S]ymbols",
    remap = false,
    buffer = bufnr,
  })

  vim.keymap.set("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>", {
    desc = "[G]oto definition [V]ertical",
    remap = false,
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", remap = false, buffer = bufnr })

  vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "[C]ode [A]ction", remap = false, buffer = bufnr }
  )
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect
      require('lsp-zero.settings').preset({})
    end
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
      require('lsp-zero.cmp').extend()
      local cmp = require("cmp")
      local select_opts = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.config.disable,
          ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
          ["<Down>"] = cmp.mapping.select_next_item(select_opts),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-l>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = vim.NIL,
          ["<S-Tab>"] = vim.NIL
        }
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'simrat39/rust-tools.nvim' },
      { 'ray-x/go.nvim' },
      { 'jose-elias-alvarez/typescript.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require("lsp-zero").preset("recommended")
      local lspconfig = require('lspconfig')

      lsp.on_attach(on_attach)

      lsp.skip_server_setup({
        "rust_analyzer",
        "tsserver",
        "go_lsp"
      })

      -- (Optional) Configure lua language server for neovim
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

      lspconfig.denols.setup({ root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc") })

      lsp.setup()

      require('typescript').setup({
        server = {
          settings = {
            completions = {
              completeFunctionCalls = true
            }
          },
          on_attach = function(client, bufnr)
            require("twoslash-queries").attach(client, bufnr)
            on_attach(client, bufnr)

            vim.keymap.set('n', '<leader>ci', '<cmd>TypescriptAddMissingImports<cr>', { buffer = bufnr })
            vim.keymap.set('n', '<leader>co', '<cmd>TypescriptOrganizeImports<cr>', { buffer = bufnr })
          end
        }
      })

      require('rust-tools').setup({
        tools = { inlay_hints = { show_parameter_hints = false } },
        server = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                enable = true,
                command = "clippy"
              }
            }
          },
          on_attach = function(client, bufnr)
            local rust_tools = require('rust_tools')
            on_attach(client, bufnr)

            vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
          end,
        },
      })

      require('go').setup({
        lsp_on_attach = function(client, bufnr)
          local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
              require('go.format').goimport()
            end,
            group = format_sync_grp,
          })

          print("Go LSP attached")

          on_attach(client, bufnr)

          vim.keymap.set("n", "K", require('go').hover_actions, { buffer = bufnr })
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

          require("typescript.extensions.null-ls.code-actions"),
        },
      })
    end
  }

}
