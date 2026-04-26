#!/bin/bash
# Get the effective user of the foreground process in a tmux pane
pane_id="$1"
tty=$(tmux display -p -t "${pane_id:?}" '#{pane_tty}' 2>/dev/null)
user=$(ps -t "$tty" -o euser=,stat= 2>/dev/null | awk '/\+/{print $1; exit}')
tmux set -g @pane_user "${user:-$(whoami)}"
