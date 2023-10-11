local utils = require('utils')

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
      },
      commits = {
        theme = "ivy",
      },
      live_grep = {
        theme           = "ivy",
        additional_args = function()
          return { "--hidden" }
        end
      },
      git_files = {
        theme = "ivy"
      },
      grep_string = {
        theme = "ivy"
      },
      oldfiles = {
        theme = "ivy"
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
  require("telescope").load_extension("live_grep_args")
end


return {
  {
    'nvim-telescope/telescope.nvim',
    keys = {

      { "<leader>,",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>:",  "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      { "<leader>ff", utils.telescope("find_files", { cwd = false }),     desc = "Find Files (root dir)" },
      { "<leader>fF", utils.telescope("find_files"),                      desc = "Find Files (cwd)" },
      { "<leader>fg", "<cmd>Telescope live_grep_args cwd=true<cr>",       desc = "Grep (cwd)" },
      { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",                desc = "Grep (root dir)" },
      { "<leader>fb", "<cmd>Telescope file_browser<cr>",                  desc = "File browser" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                      desc = "Recent" },
      { "<leader>fs", "<cmd>Telescope git_status<CR>",                    desc = "Status" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",                   desc = "Commits" },
      { "<leader>ha", "<cmd>Telescope autocommands<cr>",                  desc = "Auto Commands" },
      { "<leader>hc", "<cmd>Telescope commands<cr>",                      desc = "Commands" },
      { "<leader>hf", "<cmd>Telescope filetypes<cr>",                     desc = "File Types" },
      { "<leader>hh", "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages" },
      { "<leader>hk", "<cmd>Telescope keymaps<cr>",                       desc = "Key Maps" },
      { "<leader>hm", "<cmd>Telescope man_pages<cr>",                     desc = "Man Pages" },
      { "<leader>ho", "<cmd>Telescope vim_options<cr>",                   desc = "Options" },
      { "<leader>hs", "<cmd>Telescope highlights<cr>",                    desc = "Search Highlight Groups" },
      { "<leader>ht", "<cmd>Telescope builtin<cr>",                       desc = "Telescope" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark" },
      {
        "<leader>fd",
        utils.telescope("diagnostics"),
        desc = "[F]ind [D]iagnostics"
      },
      {
        "<leader>fw",
        utils.telescope("grep_string", { theme = "ivy" }),
        desc =
        "[F]ind current [W]ord"
      },
      {
        "<leader>ss",
        utils.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
    },
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        config = function() require('telescope').load_extension('fzf') end,
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },

      {
        "nvim-telescope/telescope-ui-select.nvim"
      },
      {
        "nvim-telescope/telescope-file-browser.nvim"

      },
    },
    cmd = 'Telescope',
    config = config,
  },
}
