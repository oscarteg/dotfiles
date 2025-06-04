return {
  name = "run script",
  builder = function()
    local file = vim.fn.expand("%:p")

    local cmd = { file }
    if vim.bo.filetype == "go" then
      cmd = { "go", "run", file }
    end

    if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
      cmd = { "bun", "run", file }
    end

    if vim.bo.filetype == "python" then
      cmd = { "python3", file }
    end

    if vim.bo.filetype == "sh" then
      cmd = { "bash", file }
    end

    return {
      cmd = cmd,
      components = {
        -- { "on_complete_notify", statuses = { "SUCCESS" } },
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "sh", "python", "go", "javascript", "typescript" },
  },
}
