-- lsp package installer
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {

    "ansible-language-server",
    "arduino-language-server",
    "clang-format",
    "clangd",
    "cmake-language-server",
    "cpptools",
    "cssmodules-language-server",
    "deno",
    "dockerfile-language-server",
    "emmet_ls",
    "eslint-ldp",
    "eslint_d",
    "go-debug-adapter",
    "goimports",
    "gopls",
    "haskell-language-server",
    "jq",
    "json-lsp",
    "kotlin_lanuage_server",
    "lua-language-server",
    "markdownlint",
    "prettierd",
    "prisma-language-server",
    "python-lsp-server",
    "rescript-lsp",
    "rust_analyzer",
    "stylua",
    "svelte-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",
    "vetur-vls",
    "vls",
    "yaml-language-server",
    "zk",
    "zls",
  },
})

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

  buf_set_keymap("n", "gD", [[<cmd> lua require('telescope.builtin').lsp.buf.declaration()<CR>]], opts)
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
    null_ls.builtins.formatting.prettierd.with({
      extra_filetypes = { "svelte" },
    }),
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.rescript,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.deno_fmt,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.yamllint,
  },
})

-- I can't get this to work. It enables in every typescript file
-- nvim_lsp.denols.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
-- })

-- typescript
nvim_lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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

-- JSON
nvim_lsp.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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

-- rescript
nvim_lsp.rescriptls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern("bsconfig.json"),
  cmd = {
    "node",
    "/Users/oscar/.local/share/nvim/site/pack/packer/start/vim-rescript/server/out/server.js",
    "--stdio",
  },
})

-- TailwindCSS
nvim_lsp.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern("tailwind.config.js"),
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

-- sourcekit
nvim_lsp.sourcekit.setup({})

-- clangd
nvim_lsp.clangd.setup({})

-- emmet
nvim_lsp.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})

-- kotlin
nvim_lsp.kotlin_language_server.setup({})
