local lspkind = require'lspkind'
local cmp = require'cmp'
 
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
 
	formatting = {
		format = lspkind.cmp_format(),
	},
 
	mapping = cmp.mapping.preset.insert({
		['<C-b>']     = cmp.mapping.scroll_docs(-4),
		['<C-f>']     = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>']     = cmp.mapping.abort(),
		['<CR>']      = cmp.mapping.confirm({ select = true })
	}),
 
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'vsnip' },
	}
}
