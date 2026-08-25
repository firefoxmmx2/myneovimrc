#!/bin/sh
# 由 tmux alert-activity / alert-silence 钩子调用：OpenCode 后台活动时发 KDE 通知
# 用法: notify-opencode.sh <activity|silence> <window_name> <pane_command>
type="$1"
win="$2"
cmd="$3"
# 仅对 OpenCode 窗口触发
case "$cmd$win" in
  *opencode*) ;;
  *) exit 0 ;;
esac
activef="/tmp/opencode_last_active"
now=$(date +%s)
if [ "$type" = "activity" ]; then
  echo "$now" > "$activef"
  exit 0
fi
# silence 类型：仅在“刚从活动转为静默”时视为任务完成，避免 LLM 思考 / 长期 idle 误报
lastactive=$(cat "$activef" 2>/dev/null || echo 0)
[ $((now - lastactive)) -lt 60 ] || exit 0
# 去重：90s 内只弹一次
lastf="/tmp/tmux-opencode-notify.last"
last=$(cat "$lastf" 2>/dev/null || echo 0)
[ $((now - last)) -lt 90 ] && exit 0
echo "$now" > "$lastf"
notify-send -a OpenCode -u normal "OpenCode" "任务完成 / 需要你的注意（$win）"
