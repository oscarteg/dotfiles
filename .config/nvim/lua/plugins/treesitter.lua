local config = function(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { 'BufReadPost', "BufNewFile" },
    version = false,
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor', -- Refactor module for treesitter
      'nvim-treesitter/nvim-treesitter-textobjects', -- Syntax aware text-objects, select, move, swap
      { 'windwp/nvim-ts-autotag' }, -- auto complete HTML tags
      { 'nvim-treesitter/nvim-treesitter-context', config = true }, -- Show code context

    },
    build = ":TSUpdate",
    config = config,
    opts = {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
      },
      ensure_installed = {
        "rust",
        "typescript",
        "go",
        "zig",
        "graphql",
        "lua",
        "haskell",
        "kotlin",
        "html",
        "css",
        "php",
        "tsx",
        "javascript",
        "typescript",
        "svelte",
        "vue",
        "scss",
        "css",
        "fish",
        "v",
        "prisma",
        "cpp",
        "cmake",
        "astro",
        "elm",
        "toml",
        "markdown",
        "markdown_inline"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner"
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          }
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.inner",
            ["]b"] = "@parameter.inner",
            ["]g"] = "@block.inner",
            ["]s"] = "@statement.inner",
            ["]e"] = "@function.inner",
            ["]a"] = "@attribute.inner",
            ["]c"] = "@call.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]B"] = "@parameter.outer",
            ["]G"] = "@block.outer",
            ["]S"] = "@statement.outer",
            ["]E"] = "@function.outer",
            ["]A"] = "@attribute.outer",
            ["]C"] = "@call.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.inner",
            ["[b"] = "@parameter.inner",
            ["[g"] = "@block.inner",
            ["[s"] = "@statement.inner",
            ["[e"] = "@function.inner",
            ["[a"] = "@attribute.inner",
            ["[c"] = "@call.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[B"] = "@parameter.outer",
            ["[G"] = "@block.outer",
            ["[S"] = "@statement.outer",
            ["[E"] = "@function.outer",
            ["[A"] = "@attribute.outer",
            ["[C"] = "@call.outer",
          },
        },
      },

    }
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" }
}
