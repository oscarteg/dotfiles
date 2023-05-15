return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")

          -- require('dap.ext.vscode').load_launchjs(nil, {})

          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_setup = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },
    },

    -- stylua: ignore
    keys = {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc =
        "Breakpoint Condition"
      },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc =
        "Toggle Breakpoint"
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc =
        "Continue"
      },
      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc =
        "Run to Cursor"
      },
      {
        "<leader>dg",
        function() require("dap").goto_() end,
        desc =
        "Go to line (no execute)"
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc =
        "Step Into"
      },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,   desc = "Up" },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc =
        "Run Last"
      },
      {
        "<leader>do",
        function() require("dap").step_out() end,
        desc =
        "Step Out"
      },
      {
        "<leader>dO",
        function() require("dap").step_over() end,
        desc =
        "Step Over"
      },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc =
        "Toggle REPL"
      },
      {
        "<leader>ds",
        function() require("dap").session() end,
        desc =
        "Session"
      },
      {
        "<leader>dt",
        function() require("dap").terminate() end,
        desc =
        "Terminate"
      },
      {
        "<leader>dw",
        function() require("dap.ui.widgets").hover() end,
        desc =
        "Widgets"
      },
    },
  },
  {
    'michaelb/sniprun', -- Run line/block in multiple language
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    build = 'bash ./install.sh',
    init = function()
      vim.keymap.set('n', '<F14>',
        function()
          local pos = vim.fn.winsaveview()
          require('sniprun').run('w')
          vim.fn.winrestview(pos)
        end, { desc = 'SnipRun current line and keep cursor position' })
      vim.keymap.set('v', '<F2>', function() require('sniprun').run('v') end,
        { desc = 'SnipRun highlighted region' })
      vim.keymap.set('n', '<F2>', function() require('sniprun').run() end, { desc = 'SnipRun current line' })
      vim.keymap.set('n', '<F26>', function() require('sniprun.display').close_all() end,
        { desc = 'SnipRun close all' })
    end,
    cmd = { 'SnipRun', 'SnipInfo' },
    opts = {
      selected_interpreters = {
        'Python3_original',
        'Lua_nvim',
        'GFM_original',
        'Rust_original',
        'JS_TS_deno',
        'Go_original',
        'C_original',
      },
      repl_enable = { 'Python3_original', 'Lua_nvim', 'JS_TS_deno' },
      repl_disable = { 'Lua_original' },
      live_mode_toggle = 'enable',
      display = { 'VirtualText', 'NvimNotify' },
    },
  },
}
