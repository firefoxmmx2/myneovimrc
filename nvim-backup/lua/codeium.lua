-- codeium settings
--
-- codeium airline#SetStatus setting
-- 简化fn vim函数符号
local fn = vim.fn
function check_existence(name)
    -- 首先尝试判断是否是函数
    local is_func, func_err = pcall(vim.api.nvim_call_function, name, {})
    if is_func then
        return true, "function"
    end

    -- 如果不是函数，尝试判断是否是变量
    local is_var = pcall(vim.api.nvim_get_var, name )
    if is_var then
        return true, "variable"
    end
    -- 如果两者都不是，则返回不存在
    return false, "neither"
end

function GetCodeiumStatus()
  -- lua里字符串连接符号使用两个点也就是..来操作
  return '{…}' .. fn['codeium#GetStatusString']()
end
-- 在vim环境里面调用lua的函数使用v:lua.的环境前缀
-- vim 判断是否存在函数airline
if check_existence('airline#section#create_right') then
  fn['airline#parts#define_function']('codeium', 'v:lua.GetCodeiumStatus')
  fn['airline#parts#define_condition']('codeium', "exists('*codeium#GetStatusString')")
  vim.g.airline_section_x = fn['airline#section#create_right']({ 'codeium', 'filetype' })
end
-- global enable codeium
vim.g.codeium_enabled = true
-- keymap
vim.keymap.set('n', '<a-;>', ':call codeium#Chat()<cr>')

