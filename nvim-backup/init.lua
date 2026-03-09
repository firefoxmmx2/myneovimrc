
require('plugins')
require('vimrc')
vim.cmd[[command! Reload :source $MYVIMRC]]
vim.cmd[[source /usr/share/vim/vimfiles/plugin/jad.vim]]
require('dashboard-setting')
require('coc')
require('fzf')
require('translator')
require('table-mode')
require('treesitter')
require('floaterm')
require('codeium')
require('wildfire')
require('easymotion')
require('wildernvim')
require('vimundo')
require('confcopilot')

vim.cmd[[colorscheme onedark]]
