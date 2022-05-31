local zk = require("zk")
local commands = require("zk.commands")
local api = vim.api
local M = {}

zk.setup({
	picker = "telescope"
})

function M.makeScratch()
	api.nvim_command("enew")
	zk.new()
end

return M
