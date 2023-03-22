-- coc setting
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.signcolumn = 'number'
vim.o.hidden = true
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 1000

-- Some servers have issues with backup files, see #649.
vim.o.backup = false
vim.o.writebackup = false

-- Give more space for displaying messages.
vim.o.cmdheight = 2

-- coc settings
-- coc extenstions list
vim.g.coc_global_extensions = {'coc-yank', 'coc-yaml', 'coc-json', 'coc-html', 'coc-css','coc-vetur', 'coc-git', 'coc-pairs', 'coc-snippets', 'coc-tsserver', 'coc-java', 'coc-eslint', 'coc-translator', 'coc-explorer', 'coc-xml', 'coc-tasks', 'coc-lua'}

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
vim.api.nvim_set_keymap('i', '<TAB>', 'pumvisible() ? "<C-n>" : <SID>check_back_space() ? "<TAB>" : coc#refresh()', {expr = true})
vim.api.nvim_set_keymap('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "<Tab>" : coc#refresh()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-TAB>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', {expr = true})

function CheckBackspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.')[col]  ==# ' '
end

-- Use <c-space> to trigger completion.
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', {expr = true})

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
vim.api.nvim_set_keymap('i', '<CR>', 'coc#pum#visible()?coc#pum#confirm():<C-g>u<CR><c-r> =coc#on_enter()<CR>', {expr = true})

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_command('autocmd CursorHold * silent call CocActionAsync("highlight")')

-- Symbol renaming.
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {silent = true})

-- Formatting selected code.
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', {})
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', {})
vim.api.nvim_set_keymap('n', '<leader>gf', ':Format<cr>', {silent = true})

vim.api.nvim_command('augroup mygroup')
vim.api.nvim_command('autocmd!')
-- Setup formatexpr specified filetype(s).
vim.api.nvim_command('autocmd FileType typescript,json setl formatexpr=CocAction("formatSelected")')
-- Update signature help on jump placeholder.
vim.api.nvim_command('autocmd User CocJumpPlaceholder call CocActionAsync("showSignatureHelp")')
vim.api.nvim_command('augroup end')

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {})

-- Remap keys for applying codeAction to the current buffer.
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', {})
-- Apply AutoFix to problem on the current line.
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', {})

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.api.nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('x', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('o', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('x', 'ac', '<Plug>(coc-classobj-a)', {})
vim.api.nvim_set_keymap('o', 'ac', '<Plug>(coc-classobj-a)', {})

-- Remap <C-f> and <C-b> for scroll float windows/popups.
if vim.fn.has('nvim-0.4.0') or vim.fn.has('patch-8.2.0750') then
  vim.api.nvim_set_keymap('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : <C-f>', {silent = true, expr = true})
  vim.api.nvim_set_keymap('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', {silent = true, expr = true})
  vim.api.nvim_set_keymap('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : <Right>"', {silent = true, expr = true})
  vim.api.nvim_set_keymap('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : <Left>"', {silent = true, expr = true})
  vim.api.nvim_set_keymap('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', {silent = true, expr = true})
  vim.api.nvim_set_keymap('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', {silent = true, expr = true})
end

-- Use CTRL-S for selections ranges. Requires 'textDocument/selectionRange' support of language server.
vim.api.nvim_set_keymap('n', '<C-s>', '<Plug>(coc-range-select)', {silent = true})
vim.api.nvim_set_keymap('v', '<C-s>', '<Plug>(coc-range-select)', {silent = true})

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")


-- Mappings for CoCList
-- Show all diagnostics.
vim.api.nvim_set_keymap('n', '<space>a', ':<C-u>CocList diagnostics<cr>', {silent = true})
-- Manage extensions.
vim.api.nvim_set_keymap('n', '<space>e', ':<C-u>CocList extensions<cr>', {silent = true})
-- Show commands.
vim.api.nvim_set_keymap('n', '<space>c', ':<C-u>CocList commands<cr>', {silent = true})
-- Find symbol of current document.
vim.api.nvim_set_keymap('n', '<space>o', ':<C-u>CocList outline<cr>', {silent = true})
-- Search workspace symbols.
vim.api.nvim_set_keymap('n', '<space>s', ':<C-u>CocList -I symbols<cr>', {silent = true})
-- Do default action for next item.
vim.api.nvim_set_keymap('n', '<space>j', ':<C-u>CocNext<CR>', {silent = true})
-- Do default action for previous item.
vim.api.nvim_set_keymap('n', '<space>k', ':<C-u>CocPrev<CR>', {silent = true})
-- Resume latest coc list.
vim.api.nvim_set_keymap('n', '<space>p', ':<C-u>CocListResume<CR>', {silent = true})

-- coc explorer
vim.api.nvim_set_keymap('n', '<leader>tt', ':CocCommand explorer<cr>', {silent = true})
