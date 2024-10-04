vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = 'off'
vim.opt.bg = 'dark'

local defaults = { noremap = true, silent = true }
local map = function(a, b)
	vim.api.nvim_set_keymap('n', a, b, defaults)
	vim.api.nvim_set_keymap('v', a, b, defaults)
	vim.api.nvim_set_keymap('o', a, b, defaults)
end

vim.api.nvim_set_keymap('t', '<Esc>', "<C-\\><C-n>", defaults)

local autocmd = vim.api.nvim_create_autocmd

map('j', 'd')
map('k', 't')
map('s', ':')
map('l', 'n')

map('d', 'h')
map('h', 'j')
map('t', 'k')
map('n', 'l')

map('D', '^')
map('H', '5j')
map('T', '5k')
map('N', '$')

map('<C-d>', '<C-W><C-h>')
map('<C-h>', '<C-W><C-j>')
map('<C-t>', '<C-W><C-k>')
map('<C-n>', '<C-W><C-l>')


-- autocmd('BufEnter', {
-- 	callback = function()
-- 		vim.o.syntax = 'off'
-- 	end
-- })

-- Remove whitespace on save
autocmd('BufWritePre', {
	pattern = '',
	command = ":%s/\\s\\+$//e"
})

-- Open a Terminal on the bottom tab
autocmd('CmdlineEnter', {
  command = 'command! Term :below new term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
	command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
	pattern = '',
	command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
	pattern = 'term://*',
	command = 'stopinsert'
})

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tommcdo/vim-lion'

	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require'config.telescope_setup'
			require'config.telescope'
		end
	}

	use {
		'neovim/nvim-lspconfig',
		config = [[ require'config.lsp' ]],
		requires = {
			'RishabhRD/popfix',
			'RishabhRD/nvim-lsputils',
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		    	"lukas-reineke/lsp-format.nvim"
		}
	}

	use {
		'hrsh7th/nvim-cmp',
		config = [[ require'config.cmp' ]],
		requires = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'neovim/nvim-lspconfig',
			'onsails/lspkind-nvim'

		}
	}

	 use {
 		'kevinhwang91/nvim-fundo',
		requires = { 'kevinhwang91/promise-async' },
 		run = function() require'fundo'.install() end,
 		config = function()
			require'fundo'.setup()
			vim.o.undofile = true
		end
 	}

	use {
		'nvim-telescope/telescope-ui-select.nvim',
		config = function()
			vim.keymap.set({ "v", "n" }, "gf", vim.lsp.buf.code_action)
		end,
	}

	-- use 'navarasu/onedark.nvim'
	use 'RRethy/base16-nvim'
	use 'tpope/vim-eunuch'
	use 'lewis6991/gitsigns.nvim'
end)

-- require('onedark').setup  {
--     -- Main options --
--     style = 'darker',
--     transparent = true,  -- Show/hide background
--     term_colors = true,
--     ending_tildes = false,
--     cmp_itemkind_reverse = false,
--
--     code_style = {
--         comments = 'italic',
--         keywords = 'none',
--         functions = 'none',
--         strings = 'none',
--         variables = 'none'
--     },
--
--     lualine = {
--         transparent = false, -- lualine center bar transparency
--     },
--
--     diagnostics = {
--         darker = true,
--         undercurl = true,
--         background = false,
--     },
-- }
--
-- require('onedark').load()


require('base16-colorscheme').with_config({
    telescope = true,
    cmp = true,
})

vim.cmd("colorscheme base16-default-dark")

require 'config.statusline'
require('gitsigns').setup()
