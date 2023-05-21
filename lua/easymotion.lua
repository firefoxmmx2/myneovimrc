local keyset = vim.keymap.set

keyset('n','s','<Plug>(easymotion-f2)')
keyset('n','S','<Plug>(easymotion-F2)')
-- 智能匹配大小写
vim.g.EasyMotion_smartcase = 1
-- 可视模式可以使用s定位跳跃
keyset('v','s','<Plug>(easymotion-f2)')
-- 可视模式可以使用S定位跳跃
keyset('v','S','<Plug>(easymotion-F2)')
