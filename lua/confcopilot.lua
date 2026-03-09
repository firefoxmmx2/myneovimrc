-- 设置下一个建议的快捷键
--
local map = vim.keymap.set
local umap = vim.keymap.unset

local function is_copilot_enabled()
  vim.api.nvim_echo('vim.g.copilot_enabled = ', vim.g.copilot_enabled)
  return vim.g.copilot_enabled == 1
end
-- 根据 Copilot 状态设置快捷键
local function set_suggestion_shortcuts()
  if is_copilot_enabled() then
    -- Copilot 插件打开时，将 alt-] 和 alt-[ 绑定到 Copilot 的下一个和上一个建议
    umap('i', '<A-]>')
    umap('i', '<A-[>')
    map('i', '<A-]>', '<Plug>(copilot-next)', {})
    map('i', '<A-[>', '<Plug>(copilot-previous)', {})
  end
end

-- 监听事件，例如当你执行 copilot enable 或其他可能的操作时调用 set_copilot_shortcuts 函数
-- 假设你在执行 copilot enable 时会触发 User CopilotEnable 事件
vim.api.nvim_create_autocmd("User", {
    pattern = "CopilotEnable",
    callback = function()
        set_suggestion_shortcuts()
    end
})
-- 我怎么知道在 CopilotEnable 事件中调用 set_suggestion_shortcuts 函数呢？

-- 打开 Copilot 时设置快捷键
vim.g.copilot_enabled = 0

