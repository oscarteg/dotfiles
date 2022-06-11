local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local null_ls = require("null-ls")

-- diagnostics signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gd", [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], opts)
  buf_set_keymap("n", "gi", [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
  buf_set_keymap("n", "gr", [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)
  buf_set_keymap("n", "<leader>d", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  buf_set_keymap("n", "<leader>ee", [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]], opts)
  buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
  buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  -- format on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
  augroup Format
  au! * <buffer>
  au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)
  augroup END
  ]] )
  end
end

-- null_ls
null_ls.setup({
  on_attach = on_attach,
  debounce = 250,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.rescript,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.php,
  },
})

-- TypeScript with tsserver
nvim_lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern("package.json"),
})

-- JSON
nvim_lsp.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "vscode-json-languageserver", "--stdio" },
  flags = {
    debounce_text_changes = 150,
  },
})

-- Lua
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
  flags = {
    debounce_text_changes = 150,
  },
})

-- XML
nvim_lsp.lemminx.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "lemminx" },
  flags = {
    debounce_text_changes = 150,
  },
})

-- TailwindCSS
nvim_lsp.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
})

-- Rust
require("rust-tools").setup({
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

-- Golang
nvim_lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- Zig
nvim_lsp.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- PHP
nvim_lsp.phpactor.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Python3
nvim_lsp.pylsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Haskell
nvim_lsp.hls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "haskell", "lhaskell" },
  root_dir = require("lspconfig/util").root_pattern(
    "*.cabal",
    "stack.yaml",
    "cabal.project",
    "package.yaml",
    "hie.yaml"
  ),
})

-- Svelte
nvim_lsp.svelte.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Vue
nvim_lsp.vuels.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- zk Note taking
nvim_lsp.zk.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

nvim_lsp.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})
