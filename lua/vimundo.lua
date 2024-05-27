
-- Enable persistent undo so that undo history persists across vim sessions
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.cache/vim/undo')
