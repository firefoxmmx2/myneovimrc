#!/bin/bash
set -e

REPO_DIR="$HOME/.config/nvim"
BRANCH="main"

cd "$REPO_DIR"

# 拉取远程最新
git fetch origin "$BRANCH" 2>/dev/null || true

# 如果有本地变更则提交
if ! git diff-index --quiet HEAD --; then
    git add -A
    git commit -m "$(date '+%a %b %d %I:%M:%S %p CST %Y') auto commit" || true
fi

# 变基并推送
git pull --rebase origin "$BRANCH" 2>/dev/null || true
git push origin "$BRANCH" 2>/dev/null || true
