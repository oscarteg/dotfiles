local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	formatting = {
         format = lspkind.cmp_format {
            with_text = true,
            menu = {
               buffer   = "[buf]",
               nvim_lsp = "[LSP]",
               path     = "[path]",
            },
         },
      },
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-y>"] = cmp.config.disable,
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-l>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ 
			behavior = cmp.ConfirmBehavior.Insert,
			select = true 
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				map.select_next_item()
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.fn.feedkeys(keymap.t("<Plug>(vsnip-expand-or-jump)"), "")
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				map.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				vim.fn.feedkeys(keymap.t("<Plug>(vsnip-jump-prev)"), "")
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Show diagnostic popup on cursor hover 
vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })")
