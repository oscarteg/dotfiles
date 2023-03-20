local config = function()
  local telescope = require('telescope')
  local lga_actions = require('telescope-live-grep-args.actions')

  telescope.setup({
    defaults = {
      color_devicons = false,
      file_ignore_patterns = { "node_modules", ".git", "build", "dist" },
      dynamic_preview_title = true,
      theme = "ivy",
      path_display = {
        truncate = 3,
      }
    },
    pickers = {
      find_files = {
        theme = "ivy",
        hidden = true,
        -- find_command = {
        --   'fd',
        --   '--type',
        --   'file',
        --   '--type',
        --   'symlink',
        --   '--hidden',
        --   '--exclude',
        --   '.git',
        -- }
      },
      git_status = {
        theme = "ivy"
      },
      lsp_document_symbols = {
        theme = "ivy"
      },
      lsp_definitions = {
        theme = "ivy"
      },
      lsp_references = {
        theme = "ivy"
      },
      lsp_type_definitions = {
        theme = "ivy"
      },
      lsp_workspace_symbols = {
        theme = "ivy"
      },
      buffers = {
        theme = "ivy"
      },
      diagnostics = {
        theme = "ivy"
      }
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_cursor({}),
      },
      file_browser = {
        hidden = true
      },
      live_grep_args = {
        auto_quoting = true,
        theme = "ivy",
        hidden = true,
        additional_args = function()
          return { "--hidden" }
        end,
        mappings = {
          -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
    },
  })
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("file_browser")
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        config = function() require('telescope').load_extension('fzf') end,
        build = 'make',
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function() require('telescope').load_extension('live_grep_args') end,
      },

      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" }
    },
    cmd = 'Telescope',
    config = config,
  },
}
