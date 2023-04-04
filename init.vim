" packer plugin manager
lua require('plugins')
lua require('vimrc')
command! Reload :source $MYVIMRC
source /usr/share/vim/vimfiles/plugin/jad.vim
lua require('dashboard-setting')
lua require('coc')
lua require('fzf')
lua require('translator')
lua require('table-mode')
lua require('treesitter')
lua require('floaterm')
lua require('codeium')
lua require('wildfire')
" lua require('mini-nvim')
lua require('easymotion')
source ~/.config/nvim/wilder.vim
" color scheme
colorscheme onedark
" transparent bg
hi Normal guibg=NONE ctermbg=NONE
