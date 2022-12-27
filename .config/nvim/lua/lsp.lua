local root_pattern = require("lspconfig.util").root_pattern

local present, lsp = pcall(require, "lsp-zero")
if not present then
	return
end

-- Utils
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		-- filter = function(client)
		-- return client.name == "null-ls"
		-- return client.name ~= "tsserver"
		-- end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {
		desc = "[G]oto [R]eferences",
		remap = false,
		buffer = bufnr,
	})
	vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, {
		desc = "[D]ocument [S]ymbols",
		remap = false,
		buffer = bufnr,
	})
	vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, {
		desc = "[W]orkspace [S]ymbols",
		remap = false,
		buffer = bufnr,
	})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", remap = false, buffer = bufnr })
	vim.keymap.set(
		"n",
		"<leader>ca",
		vim.lsp.buf.code_action,
		{ desc = "[C]ode [A]ction", remap = false, buffer = bufnr }
	)
	vim.keymap.set("n", "<leader>f", function()
		lsp_formatting(bufnr)
	end, { desc = "[F]ormat", remap = false, buffer = bufnr })

	-- format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end -- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		lsp_formatting(bufnr)
	end, {
		desc = "Format current buffer with LSP",
	})
end

-- Inline Hints
-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/65
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- LSP settings
lsp.preset("recommended")

--- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })

lsp.configure("denols", { root_dir = root_pattern("deno.json", "deno.jsonc") })

lsp.configure("tsserver", {
	root_dir = root_pattern("package.json"),
	commands = {
		OrganizeImports = {
			function()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
			end,
			description = "Organize imports",
		},
	},
})

-- Completion
local cmp = require("cmp")
local select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-y>"] = cmp.config.disable,
	["<Up>"] = cmp.mapping.select_prev_item(select_opts),
	["<Down>"] = cmp.mapping.select_next_item(select_opts),
	["<C-j>"] = cmp.mapping.select_next_item(),
	["<C-k>"] = cmp.mapping.select_prev_item(),
	["<C-l>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
	["<CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
})

-- disable completion with tab
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({ mapping = cmp_mappings })

lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
})

lsp.nvim_workspace()

lsp.on_attach(on_attach)

-- Go
local go_lsp = lsp.build_options("go")
-- Rust
local rust_lsp = lsp.build_options("rust_analyzer", { checkOnSave = { command = "clippy" } })

require("rust-tools").setup({
	tools = { inlay_hints = { show_parameter_hints = false } },
	server = rust_lsp,
})

-- Golang
require("go").setup({ server = go_lsp })

lsp.setup()

-- Null LS

local present, null_ls = pcall(require, "null-ls")
if not present then
	return
end

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({ automatic_installation = true, automatic_setup = true })
mason_null_ls.setup_handlers({})
