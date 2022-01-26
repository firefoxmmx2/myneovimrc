"plugins manager
call plug#begin('~/.vim/plugged')
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentline'
Plug 'neoclide/coc.nvim',{'branch': 'release'}
Plug 'luochen1990/rainbow'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'github/copilot.vim'
Plug 'posva/vim-vue'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'juneedahamed/vc.vim'
Plug 'joshdick/onedark.vim'
Plug 'lilydjwg/fcitx.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/dashboard-nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'puremourning/vimspector'
call plug#end()

source ~/.config/nvim/vimrc.vim
command! Reload :source $MYVIMRC
source ~/.config/nvim/coc.vim
source ~/.config/nvim/copilot.vim
source ~/.config/nvim/fzf.vim
source ~/.config/nvim/dashboard.vim
source ~/.config/nvim/translator.vim
source ~/.config/nvim/table-mode.vim

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg
" color scheme
colorscheme onedark
