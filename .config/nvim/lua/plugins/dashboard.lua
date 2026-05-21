-- Read git branch from .git/HEAD (no subprocess, works for jj-colocated repos).
-- Returns nil for pure-jj or non-git directories.
local function get_branch()
  local f = io.open(vim.fn.getcwd() .. "/.git/HEAD", "r")
  if not f then return nil end
  local head = f:read("*l")
  f:close()
  if not head then return nil end
  return head:match("^ref: refs/heads/(.+)") or head:sub(1, 7)
end

-- Read the latest commit's short hash + summary.
local function get_commit()
  local out = vim.fn.systemlist({ "git", "-C", vim.fn.getcwd(), "log", "-1", "--pretty=format:%h %s" })
  if vim.v.shell_error ~= 0 or not out or not out[1] then return nil end
  return out[1]
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = "",
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = function() require("fff").find_files() end },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = function() require("fff").live_grep() end },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        formats = {
          -- Highlight the first letter of each desc with the key color
          -- (matches the shortcut letter on the right). Mimics LazyVim's default.
          desc = function(item)
            if not item.desc then
              return { "", hl = "SnacksDashboardDesc" }
            end
            return {
              { item.desc:sub(1, 1), hl = "SnacksDashboardKey" },
              { item.desc:sub(2),    hl = "SnacksDashboardDesc" },
            }
          end,
        },
        sections = {
          { section = "keys", gap = 1, padding = 1 },
          -- right pane: live git status, cached 5min, hidden outside git repos
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 10,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          -- bottom: branch + last commit (replaces the startup-time line)
          function()
            local branch = get_branch()
            if not branch then return nil end
            local commit = get_commit()
            local text = " " .. branch
            if commit then
              text = text .. "  " .. commit
            end
            return {
              text = { { text, hl = "SnacksDashboardFooter" } },
              align = "center",
              padding = 1,
            }
          end,
        },
      },
    },
  },
}
