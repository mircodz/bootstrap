local defaults = {noremap = true, silent = true}
local nmap = function(from, to) vim.api.nvim_set_keymap('n', from, to, defaults) end

nmap('<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
nmap('<Space>sp', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
-- nmap('<Space>sP', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
nmap('<Space>sP', [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]])
