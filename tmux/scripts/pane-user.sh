#!/bin/bash
pane_id="${TMUX_PANE:-$1}"
if [ -z "$pane_id" ]; then
    pane_id=$(tmux display -p '#{pane_id}' 2>/dev/null)
fi
if [ -n "$pane_id" ]; then
    tty=$(tmux display -p -t "$pane_id" '#{pane_tty}' 2>/dev/null)
    user=$(ps -t "$tty" -o euser=,stat= 2>/dev/null | awk '/\+/{print $1; exit}')
fi
echo "${user:-$(whoami)}"
