#!/bin/bash

# tmux prefix 触发前关闭 fcitx5 输入法
# 如果当前是中文模式，切换到英文模式

if command -v fcitx5-remote &>/dev/null; then
    # 获取当前状态：0=关闭，1=英文，2=中文
    state=$(fcitx5-remote 2>/dev/null)
    
    # 如果是中文模式 (2)，切换到英文模式 (1)
    if [ "$state" = "2" ]; then
        fcitx5-remote -t 2>/dev/null
    fi
fi

exit 0
