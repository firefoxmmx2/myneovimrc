" packer plugin manager
lua require('plugins')
lua require('vimrc')
lua require('coc')
command! Reload :source $MYVIMRC
source ~/.vim/plugged/jad.vim/jad.vim
source ~/.config/nvim/blamer.vim
source ~/.config/nvim/wildfire.vim
source ~/.config/nvim/codeium.vim
lua require('dashboard-setting')
lua require('leap').add_default_mappings()
lua require('coc')
lua require('fzf')
lua require('translator')
lua require('table-mode')
lua require('treesitter')
lua require('floaterm')
" lua require('codeium')
" color scheme
colorscheme onedark
" transparent bg
hi Normal guibg=NONE ctermbg=NONE
