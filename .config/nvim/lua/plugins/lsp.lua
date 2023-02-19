local on_attach = function(client, bufnr)
  local lsp_format = require("lsp-format")
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {
    desc = "[G]oto [R]eferences",
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
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", remap = false, buffer = bufnr })
  vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "[C]ode [A]ction", remap = false, buffer = bufnr }
  )

  lsp_format.on_attach(client, bufnr)
end

local config = function()
  local root_pattern = require("lspconfig.util").root_pattern
  local lsp = require("lsp-zero")
  local rust_tools = require("rust-tools")

  -- Inline Hints
  -- https://github.com/VonHeikemen/lsp-zero.nvim/issues/65
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    severity_sort = true,
    update_in_insert = false,
  })

  -- LSP settings
  lsp.preset("recommended")

  --- Fix Undefined global 'vim'
  lsp.configure("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })

  lsp.configure("denols", { root_dir = root_pattern("deno.json", "deno.jsonc") })

  lsp.configure("tsserver", {
    -- on_attach = function(client, bufnr)
    --   require("twoslash-queries").attach(client, bufnr)
    --   on_attach(client, bufnr)
    -- end,
    root_dir = root_pattern("package.json"),
    commands = {
      OrganizeImports = {
        function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          }
          vim.lsp.buf.execute_command(params)
        end,
        description = "Organize imports",
      },
    },
  })

  -- Completion
  local cmp = require("cmp")
  local select_opts = { behavior = cmp.SelectBehavior.Select }
  local cmp_mappings = lsp.defaults.cmp_mappings({
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
  })

  -- disable completion with tab
  cmp_mappings["<Tab>"] = nil
  cmp_mappings["<S-Tab>"] = nil

  lsp.setup_nvim_cmp({ mapping = cmp_mappings })

  lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
  })

  lsp.nvim_workspace()

  lsp.skip_server_setup({ 'rust_analyzer' })

  lsp.on_attach(on_attach)

  lsp.setup()

  -- Rust
  local rust_lsp = lsp.build_options("rust_analyzer", { checkOnSave = { command = "clippy" } })


  rust_tools.setup({
    tools = { inlay_hints = { show_parameter_hints = false } },
    server = {
      on_attach = function(client, bufnr)
        rust_lsp.on_attach(client, bufnr)

        -- Use hover actions of rust-tools to add the actions
        vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      end,
    },
  })

  -- Go
  local present, go_lang = pcall(require, "go")
  if not present then
    return
  end

  local go_lsp = lsp.build_options("go")

  go_lang.setup({ server = go_lsp })
end

local config_null_ls = function()
  local null_ls = require("null-ls")
  local lsp = require("lsp-zero")

  -- Null LS
  local null_opts = lsp.build_options("null-ls", {})

  null_ls.setup({
    on_attach = function(client, bufnr)
      null_opts.on_attach(client, bufnr)
    end,
    sources = {
      null_ls.builtins.diagnostics.php,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.cmake_lint,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.formatting.prismaFmt,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.cmake_format,
    },
  })
end


return {
  "VonHeikemen/lsp-zero.nvim",
  event = "VeryLazy", -- lazy-load lsp-zero.nvim itself
  dependencies = {
    {
      "neovim/nvim-lspconfig", -- load nvim-lspconfig on BufReadPre (before loading Treesitter on BufReadPost)
      event = "BufReadPre",
    },
    {
      "williamboman/mason.nvim",
      dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        { "jose-elias-alvarez/null-ls.nvim", config = config_null_ls },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter", -- load nvim-cmp on InsertEnter; this is ignored(?), as nvim-cmp is loaded with lsp-zero.nvim
      dependencies = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
      },
    },
    {
      "lukas-reineke/lsp-format.nvim",
      opts = {
        exclude = { "tsserver", "denols" },
      }
    }
  },
  config = config
}
