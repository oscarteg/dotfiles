local config = function(_, opts)
  vim.treesitter.language.register('markdown', 'mdx')
  require("nvim-treesitter.install").compiler = { "clang" }
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
      "clojure",
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
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
          ["<leader>nm"] = "@function.outer",  -- swap function with next
        },
        swap_previous = {
          ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
          ["<leader>pm"] = "@function.outer",  -- swap function with previous
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
          ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
          ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
          ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
          ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },


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
      { 'windwp/nvim-ts-autotag' },                                 -- auto complete HTML tags
      { 'nvim-treesitter/nvim-treesitter-context', config = true }, -- Show code context

    },
    build = ":TSUpdate",
    config = config,
  },
  {
    -- Extend and create a/i textobjects
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      ---@type table<string, string|table>
      local i = {
        [" "] = "Whitespace",
        ['"'] = 'Balanced "',
        ["'"] = "Balanced '",
        ["`"] = "Balanced `",
        ["("] = "Balanced (",
        [")"] = "Balanced ) including white-space",
        [">"] = "Balanced > including white-space",
        ["<lt>"] = "Balanced <",
        ["]"] = "Balanced ] including white-space",
        ["["] = "Balanced [",
        ["}"] = "Balanced } including white-space",
        ["{"] = "Balanced {",
        ["?"] = "User Prompt",
        _ = "Underscore",
        a = "Argument",
        b = "Balanced ), ], }",
        c = "Class",
        f = "Function",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
      }
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        a[k] = v:gsub(" including.*", "")
      end

      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs({ n = "Next", l = "Last" }) do
        i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
        a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
      end
      require("which-key").register({
        mode = { "o", "x" },
        i = i,
        a = a,
      })
    end,
  }
}
