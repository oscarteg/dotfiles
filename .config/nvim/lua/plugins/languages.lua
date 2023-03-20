return {
  { "simrat39/rust-tools.nvim",   ft = { "rs" } },  -- Rust
  { "rescript-lang/vim-rescript", ft = { "res" } }, -- Rescript
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build =
    ':lua require("go.install").update_all_sync()'                                                 -- if you need to install/update all binaries
  },
  { "ziglang/zig.vim",                  ft = "zig" },                                              -- Zig
  { "marilari88/twoslash-queries.nvim", config = true, ft = { "typescript", "typescriptreact" } }, -- typescript type
}
