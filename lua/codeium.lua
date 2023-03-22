-- codeium settings
--
-- codeium airline#SetStatus setting
function GetCodeiumStatus()
  return '{…}' .. codeium.GetStatusString()
end

vim.fn['airline#parts#define_function']('codeium', GetCodeiumStatus)
vim.fn['airline#parts#define_condition']('codeium', vim.fn.exists('*codeium#GetStatusString'))
vim.g.airline_section_x = vim.fn['airline#section#create_right']({ 'codeium', 'filetype' })
-- global enable codeium
vim.g.codeium_enabled = true
