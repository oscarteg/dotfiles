local config = function(_, opts)
  require("nvim-treesitter.configs").setup({
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    ensure_installed = {
      "astro",
      "arduino",
      "c",
      "cmake",
      "cpp",
      "css",
      "css",
      "dart",
      "dockerfile",
      "elm",
      "fish",
      "go",
      "graphql",
      "haskell",
      "html",
      "javascript",
      "json",
      "kotlin",
      "lua",
      "markdown",
      "markdown_inline",
      "meson",
      "php",
      "prisma",
      "rust",
      "scala",
      "scss",
      "swift",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "typescript",
      "v",
      "vue",
      "yaml",
      "zig",
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
      select = {
        enable = true,
        lookahead = true,
        -- Set the jumps in the jump list
        set_jumps = true,
        keymaps = {
          ["aa"] = "@attribute.outer",
          ["ia"] = "@attribute.inner",
          ["aB"] = "@parameter.outer",
          ["ab"] = "@parameter.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["ad"] = "@comment.outer",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@statement.inner",
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
  )
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { 'BufReadPost', "BufNewFile" },
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',                   -- Refactor module for treesitter
      'nvim-treesitter/nvim-treesitter-textobjects',                -- Syntax aware text-objects, select, move, swap
      { "nvim-treesitter/playground",              cmd = "TSPlaygroundToggle" },
      { 'windwp/nvim-ts-autotag' },                                 -- auto complete HTML tags
      { 'nvim-treesitter/nvim-treesitter-context', config = true }, -- Show code context

    },
    build = ":TSUpdate",
    config = config,
  },
}
