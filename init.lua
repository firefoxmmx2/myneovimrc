-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 映射 ctrl+shift+u/d 和 shift+enter
vim.keymap.set('n', '<C-S-u>', '<C-u>', { desc = 'Scroll up' })
vim.keymap.set('n', '<C-S-d>', '<C-d>', { desc = 'Scroll down' })
vim.keymap.set('i', '<C-S-u>', '<C-u>', { desc = 'Scroll up' })
vim.keymap.set('i', '<C-S-d>', '<C-d>', { desc = 'Scroll down' })

-- shift+enter 在插入模式下换行不退出
vim.keymap.set('i', '<S-CR>', '<CR>', { desc = 'Enter' })
