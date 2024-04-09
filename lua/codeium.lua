-- codeium settings
--
-- codeium airline#SetStatus setting
-- 简化fn vim函数符号
local fn = vim.fn
function GetCodeiumStatus()
  -- lua里字符串连接符号使用两个点也就是..来操作
  return '{…}' .. fn['codeium#GetStatusString']()
end
-- 在vim环境里面调用lua的函数使用v:lua.的环境前缀
fn['airline#parts#define_function']('codeium', 'v:lua.GetCodeiumStatus')
fn['airline#parts#define_condition']('codeium', "exists('*codeium#GetStatusString')")
vim.g.airline_section_x = fn['airline#section#create_right']({ 'codeium', 'filetype' })
-- global enable codeium
vim.g.codeium_enabled = true
-- keymap
vim.keymap.set('n', '<a-;>', ':call codeium#Chat()<cr>')
