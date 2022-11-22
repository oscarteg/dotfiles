local api = vim.api
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local null_ls = require("null-ls")

-- lsp package installer
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true
})

-- diagnostics signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    async = true,
    filter = function(client)
      return client.name ~= "tsserver"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Telescope
  vim.keymap.set("n", "gd", require('telescope.builtin').lsp_definitions, bufopts)
  vim.keymap.set('n', '<space>D', require('telescope.builtin').lsp_type_definitions, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gi", require('telescope.builtin').lsp_implementations, bufopts)
  vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, bufopts)
  vim.keymap.set("n", "<leader>d", require('telescope.builtin').lsp_document_symbols, bufopts)
  vim.keymap.set("n", "<leader>ee", require('telescope.builtin').diagnostics, bufopts)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>f", function() lsp_formatting(bufnr) end, bufopts)
  vim.keymap.set("n", '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "]g", vim.diagnostic.goto_next, bufopts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)

  -- format on save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

--[[ deno ]]
nvim_lsp.denols.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")
})

--[[ typescript ]]
nvim_lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
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

--[[ JSON ]]
nvim_lsp.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

--[[ Lua ]]
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

--[[ TailwindCSS ]]
nvim_lsp.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern("tailwind.config.js"),
})

-- Rust
require("rust-tools").setup({
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
    },
  },

  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

-- golang
require("go").setup({})

-- Zig
nvim_lsp.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Python3
nvim_lsp.pylsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Haskell
--[[ nvim_lsp.hls.setup({ ]]
--[[   capabilities = capabilities, ]]
--[[   on_attach = on_attach, ]]
--[[ }) ]]

-- Svelte
nvim_lsp.svelte.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Vue
--[[ nvim_lsp.vuels.setup({ ]]
--[[   capabilities = capabilities, ]]
--[[   on_attach = on_attach, ]]
--[[ }) ]]

-- clangd
nvim_lsp.clangd.setup({})

-- emmet
nvim_lsp.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "astro", "svelte", "vue" },
})

-- kotlin
nvim_lsp.kotlin_language_server.setup({})

-- astro
nvim_lsp.astro.setup({})

--[[Elm]]
nvim_lsp.elmls.setup({})

-- null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim
null_ls.setup({
  on_attach = on_attach,
  debounce = 250,
  sources = {
    -- formatting
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.zigfmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettier.with({
      extra_filetypes = { "mdx" },
    }),
    null_ls.builtins.formatting.elm_format,
    null_ls.builtins.formatting.rescript,

    -- diagnostics
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.eslint_d,
    -- code actions
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
  },
})
