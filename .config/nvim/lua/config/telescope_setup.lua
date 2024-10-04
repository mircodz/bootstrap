require'telescope'.setup {
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
			'--hidden'
		}
	},

	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
		},
		sorting_strategy = "ascending",
	},

	pickers = {
		lsp_references = { theme = 'cursor' },
		lsp_code_actions = { theme = 'cursor' },
		lsp_definitions = { theme = 'cursor' },
		lsp_implementations = { theme = 'cursor' },
		find_files = {
			previewer = false,
			hidden = false
		}
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
}

require("telescope").load_extension("ui-select")

