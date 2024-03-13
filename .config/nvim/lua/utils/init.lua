local M = {}
local root_utils = require("utils.root")

M.root_patterns = { ".git", "/lua" }

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
---@param builtin string
function M.telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = root_utils.root() }, opts or {}) --[[@as lazyvim.util.telescope.opts]]
		if builtin == "files" then
			if
				vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git")
				and not vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.ignore")
				and not vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.rgignore")
			then
				opts.show_untracked = true
				builtin = "git_files"
			else
				builtin = "find_files"
			end
		end
		if opts.cwd and opts.cwd ~= vim.loop.cwd() then
			local function open_cwd_dir()
				local action_state = require("telescope.actions.state")
				local line = action_state.get_current_line()
				M.telescope(
					params.builtin,
					vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
				)()
			end
			---@diagnostic disable-next-line: inject-field
			opts.attach_mappings = function(_, map)
				-- opts.desc is overridden by telescope, until it's changed there is this fix
				map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd directory" })
				return true
			end
		end

		require("telescope.builtin")[builtin](opts)
	end
end

-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
function M.float_term(cmd, opts)
	opts = vim.tbl_deep_extend("force", {
		size = { width = 0.9, height = 0.9 },
	}, opts or {})
	require("lazy.util").float_term(cmd, opts)
end

---@param silent boolean?
function M.toggle(option, silent)
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		vim.notify(
			(vim.opt_local[option]:get() and "Enabled" or "Disabled") .. " " .. option,
			vim.log.levels.INFO,
			{ title = "Option" }
		)
	end
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

return M
