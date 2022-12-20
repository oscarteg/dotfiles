require("nvim-treesitter.configs").setup({
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
    "elm"
  },
  highlight = {
    enable = true,
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
      ["iL"] = {
        -- you can define your own textobjects directly here
        go = "(function_definition) @function",
      },
      -- or you use the queries from supported languages with textobjects.scm
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
        ["]f"] = "@function.outer",
        ["]b"] = "@parameter.outer",
        ["]d"] = "@block.inner",
        ["]e"] = "@function.inner",
        ["]a"] = "@attribute.inner",
        ["]c"] = "@call.inner",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]B"] = "@parameter.outer",
        ["]D"] = "@block.inner",
        ["]E"] = "@function.inner",
        ["]A"] = "@attribute.inner",
        ["]C"] = "@call.inner",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[b"] = "@parameter.outer",
        ["[d"] = "@block.inner",
        ["[e"] = "@function.inner",
        ["[a"] = "@attribute.inner",
        ["[c"] = "@call.inner",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[B"] = "@parameter.outer",
        ["[D"] = "@block.inner",
        ["[E"] = "@function.inner",
        ["[A"] = "@attribute.inner",
        ["[C"] = "@call.inner",
      },
    },
  },
})
