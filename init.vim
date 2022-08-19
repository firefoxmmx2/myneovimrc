"plugins manager
call plug#begin('~/.vim/plugged')
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'luochen1990/rainbow'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'easymotion/vim-easymotion'
Plug 'voldikss/vim-floaterm'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'chenillen/jad.vim'
Plug 'cuducos/yaml.nvim'
Plug 'APZelos/blamer.nvim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

source ~/.config/nvim/vimrc.vim
command! Reload :source $MYVIMRC
source ~/.config/nvim/coc.vim
source ~/.config/nvim/copilot.vim
source ~/.config/nvim/fzf.vim
source ~/.config/nvim/dashboard.vim
source ~/.config/nvim/translator.vim
source ~/.config/nvim/table-mode.vim
source ~/.config/nvim/treesitter.vim
source ~/.config/nvim/floaterm.vim
source ~/.vim/plugged/jad.vim/jad.vim
source ~/.config/nvim/blamer.vim
lua require('dashboard-setting')
" color scheme
colorscheme onedark
" transparent bg
hi Normal guibg=NONE ctermbg=NONE
