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
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ib"] = "@parameter.inner",
        ["ab"] = "@parameter.outer",
        ["iB"] = "@block.inner",
        ["aB"] = "@block.outer",
        ["id"] = "@block.inner",
        ["ad"] = "@block.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ia"] = "@attribute.inner",
        ["aa"] = "@attribute.outer",
      },
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
        -- ["]c"] = "@call.inner",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]B"] = "@parameter.outer",
        ["]D"] = "@block.inner",
        ["]E"] = "@function.inner",
        ["]A"] = "@attribute.inner",
        -- ["]C"] = "@call.inner",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[b"] = "@parameter.outer",
        ["[d"] = "@block.inner",
        ["[e"] = "@function.inner",
        ["[a"] = "@attribute.inner",
        -- ["[c"] = "@call.inner",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[B"] = "@parameter.outer",
        ["[D"] = "@block.inner",
        ["[E"] = "@function.inner",
        ["[A"] = "@attribute.inner",
        -- ["[C"] = "@call.inner",
      },
    },
  },
})
