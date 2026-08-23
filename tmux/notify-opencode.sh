#!/bin/sh
# 由 tmux alert-activity 钩子调用：当 OpenCode 在后台窗口有活动时发 KDE 系统通知
win="$1"
cmd="$2"
# 仅对 OpenCode 窗口触发（窗口名或 pane 命令含 opencode）
case "$cmd$win" in
  *opencode*) ;;
  *) exit 0 ;;
esac
now=$(date +%s)
lastf="/tmp/tmux-opencode-notify.last"
last=$(cat "$lastf" 2>/dev/null || echo 0)
[ $((now - last)) -lt 90 ] && exit 0
echo "$now" > "$lastf"
notify-send -a OpenCode -u normal "OpenCode" "需要你的注意（$win）"
