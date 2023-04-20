local keyset = vim.keymap.set

keyset('n','s','<Plug>(easymotion-f2)')
keyset('n','S','<Plug>(easymotion-F2)')
-- 智能匹配大小写
vim.g.EasyMotion_smartcase = 1
