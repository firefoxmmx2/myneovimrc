-- fzf files selector
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<space>f', ':Files<cr>', {silent = true})
vim.api.nvim_set_keymap('n', '<space>h', ':History<cr>', {silent = true})
