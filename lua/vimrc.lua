-- leader key mapping
vim.g.mapleader = ","

vim.cmd('filetype on')
vim.cmd('filetype plugin on')
vim.cmd('syntax on')
-- file encoding suggest
vim.opt.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,cp950,cp932,cp949,cp1361,big5,euc-jp,euc-kr,euc-tw,latin1"
-- tab/space setting
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
-- line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoread = true
-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true
-- search hint
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.cmd("nohlsearch")
vim.api.nvim_set_keymap('n', 'n', 'nzz', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', {noremap = true})
-- set smartcase
-- fold/expand setting
vim.opt.foldenable = false
--vim.opt.foldmethod = "indent"
vim.opt.fdm = "syntax"
vim.opt.showcmd = true
--vim.opt.autochdir = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = true -- soft wrap line
-- highlight current line
vim.opt.cursorcolumn = false
-- auto complete ignore case
vim.opt.infercase = true
vim.opt.showmatch = true
-- no backup file
vim.opt.backup = false
vim.opt.swapfile = false
-- colipboard
vim.opt.clipboard = "unnamed"
-- needtree setting
vim.api.nvim_set_keymap('n', '<leader>tt', ':NERDTreeToggle<cr>', {noremap = true})
vim.cmd('noremap R :Reload<cr>')
-- reload setting command
vim.cmd("command! Reload :source $MYVIMRC<cr>")
-- intent line setting
vim.g.indent_guides_guide_size = 1
-- rainbow
vim.g.rainbow_active=1

-- tagbar file structure
vim.api.nvim_set_keymap('n', 'fs', ':TagbarToggle<cr><c-w>l', {noremap = true})
-- nerdcommenter setting
vim.g.NERDSpaceDelims=1
vim.api.nvim_set_keymap('n', '<leader>cc', '<plug>NERDCommenterToggle', {noremap = true})
-- ultisnips setting
vim.g.UltiSnipsExpandTrigger="<leader><tab>"
-- vim fcitx setting
vim.g.fcitx5_remote="fcitx5-remote"
-- window split setting
vim.api.nvim_set_keymap('n', '<leader>wsl', ':split<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wsb', ':vsplit<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wl', '<c-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wh', '<c-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wj', '<c-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wk', '<c-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wy', '3<c-w>>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wo', '3<c-w><', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wu', '3<c-w>+', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wi', '3<c-w>-', {noremap = true})
-- command mode up down mapping 
vim.api.nvim_set_keymap('c', '<c-j>', '<down>', {noremap = true})
vim.api.nvim_set_keymap('c', '<c-k>', '<up>', {noremap = true})
vim.api.nvim_set_keymap('i', '<c-j>', '<down>', {noremap = false})
vim.api.nvim_set_keymap('i', '<c-k>', '<up>', {noremap = false})

-- clipboard copy
vim.opt.clipboard = "unnamedplus"
-- quit or close buffer mapping 
vim.api.nvim_set_keymap('n', 'Q', ':call QuitOrCloseBuffer()<cr>', {noremap = true})

-- quit or close buffer
function QuitOrCloseBuffer()
  local buflen= length(vim.fn.getbufinfo({buflisted = 1}))
  if buflen <= 1 then
    vim.cmd('quit')
  else
    vim.cmd('bdelete')
  end
end

-- open file in last poisition
vim.cmd([[
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
]])

-- diff setting
vim.api.nvim_set_keymap('n', 'dp', 'dp]c', {noremap = true})
vim.api.nvim_set_keymap('n', 'do', 'do]c', {noremap = true})
-- page up
vim.api.nvim_set_keymap('n', '<c-e>', '<c-u>', {noremap = true})
vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
