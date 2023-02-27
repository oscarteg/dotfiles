return {
  'epwalsh/obsidian.nvim',
  keys = {
    { '<leader>n', ':ObsidianToday<CR>' },
  },
  opts = {
    dir = "/Users/oscar/Library/Mobile Documents/iCloud~md~obsidian/Documents/Journal of Everything",
    disable_frontmatter = true,
    note_frontmatter_func = function()
      return nil
    end,
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
    daily_notes = {
      folder = "00-inbox/01-daily",
    }

  }
}
