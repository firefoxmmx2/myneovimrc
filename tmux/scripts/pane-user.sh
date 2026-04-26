#!/bin/bash
pane_id="${TMUX_PANE:-$1}"
if [ -z "$pane_id" ]; then
    pane_id=$(tmux display -p '#{pane_id}' 2>/dev/null)
fi
if [ -n "$pane_id" ]; then
    tty=$(tmux display -p -t "$pane_id" '#{pane_tty}' 2>/dev/null)
    user=$(ps -t "$tty" -o euser=,stat= 2>/dev/null | awk '/\+/{print $1; exit}')
fi
user="${user:-$(whoami)}"

if [ "$user" = "root" ]; then
    if [ $((10#$(date +%S) % 2)) -eq 0 ]; then
        echo "#[fg=red,bg=#{@thm_surface_0}]#[fg=#{@thm_crust},bg=red] #[fg=red,bold,bg=#{@thm_surface_0}] root! #[fg=#{@thm_fg}]"
    else
        echo "#[fg=red,bg=#{@thm_surface_0}]#[fg=#{@thm_crust},bg=red] #[fg=red,bold,bg=#{@thm_surface_0}] root  #[fg=#{@thm_fg}]"
    fi
else
    echo "#[fg=#{@thm_sky},bg=#{@thm_surface_0}]#[fg=#{@thm_crust},bg=#{@thm_sky}] #[fg=#{@thm_fg},bg=#{@thm_surface_0}] $user #[fg=#{@thm_fg}]"
fi
