" leader key mapping
let g:mapleader=","

set nocompatible

filetype on
filetype plugin on
syntax on
" file encoding suggest
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,cp950,cp932,cp949,cp1361,big5,euc-jp,euc-kr,euc-tw,latin1
" tab/space setting
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
"line number
set number
set relativenumber
set autoread
" indent
set autoindent
set smartindent
" search hint
set hlsearch
set incsearch
set ignorecase
exec "nohlsearch"
nmap n nzz
nmap N Nzz
" set smartcase
" fold/expand setting
set foldenable
"set foldmethod=indent 
set fdm=syntax
set showcmd
" set autochdir 
set wildmenu
set wildmode=longest:full,full
set wrap " soft wrap line
" highlight current line
set nocursorcolumn
" auto complete ignore case
set infercase
set showmatch
" no backup file
set nobackup
set noswapfile
" needtree setting
noremap <leader>tt :NERDTreeToggle<cr>
nnoremap R :Reload<cr>
" reload setting command
command! Reload :source $MYVIMRC<cr>

" intent line setting
let g:indent_guides_guide_size=1 " line size
let g:intent_guides_start_level=2 " show line from level 2
let g:indentLine_enabled = 0 " default off
let g:indentLine_fileType = ['python']
" rainbow
let g:rainbow_active=1

" tagbar file structure
nnoremap <leader>fs :TagbarToggle<cr><c-w>l
" nerdcommenter setting
let g:NERDSpaceDelims=1
" ultisnips setting
let g:UltiSnipsExpandTrigger="<leader><tab>"
" vim fcitx setting
let g:fcitx5_remote="fcitx5-remote"
" window split setting
nnoremap <leader>wsl :split<cr>
nnoremap <leader>wsb :vsplit<cr>
nnoremap <leader>wl <c-w>l
nnoremap <leader>wh <c-w>h
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k

" command mode up down mapping 
cmap <c-j> <down>
cmap <c-K> <up>

" save
nmap S :w<cr>
" quit without save
nmap Q :q<cr>
