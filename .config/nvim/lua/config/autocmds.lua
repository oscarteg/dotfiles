-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Create a user command to run a script with overseer
vim.api.nvim_create_user_command("WatchRun", function()
  local overseer = require("overseer")

  overseer.run_template({ name = "run script" }, function(task)
    if task then
      -- Add the restart_on_save component
      task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })

      -- Store current window before any operations
      local main_win = vim.api.nvim_get_current_win()

      -- Toggle overseer window without focusing
      overseer.toggle({ enter = false })

      -- The task should already be running since autostart defaults to true
      -- If you want to open the task output, you can use:
      -- overseer.run_action(task, "open float")

      -- Ensure we're back in the main window
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("WatchRun: 'run script' template not found", vim.log.levels.ERROR)
    end
  end)
end, {})

-- Automatically organize imports on save for JavaScript and TypeScript files
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
--   callback = function()
--     vim.lsp.buf.code_action({
--       context = { only = { "source.organizeImports" } },
--       apply = true,
--     })
--   end,
-- })
