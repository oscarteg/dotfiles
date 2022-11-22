local null_ls = require("null-ls")

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
