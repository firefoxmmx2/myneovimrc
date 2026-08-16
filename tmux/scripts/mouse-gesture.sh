#!/usr/bin/env bash
# 鼠标右键拖动手势：down 记录按下位置，up 按方向执行分屏或弹出 pane 菜单
state_file="${TMPDIR:-/tmp}/tmux-gesture-start"

down() {
    printf '%s %s\n' "$2" "$3" > "$state_file"
}

up() {
    local sx sy ex ey pane dx dy ax ay
    read -r sx sy < "$state_file" 2>/dev/null || exit 0
    ex=$2; ey=$3; pane=$4
    dx=$((ex - sx)); dy=$((ey - sy))
    ax=${dx#-}; ay=${dy#-}
    if (( ax <= 5 && ay <= 5 )); then
        menu=(
            tmux display-menu
            -T "#[align=centre]#{pane_index} (#{pane_id})"
            -t "$pane" -x "$ex" -y "$ey"
            "#{?#{m/r:(copy|view)-mode,#{pane_mode}},Go To Top,}" "<" "{ send-keys -X history-top }"
            "#{?#{m/r:(copy|view)-mode,#{pane_mode}},Go To Bottom,}" ">" "{ send-keys -X history-bottom }"
            ""
            "#{?#{&&:#{buffer_size},#{!:#{pane_in_mode}}},Paste #[underscore]#{=/9/...:buffer_sample},}" p "{ paste-buffer }"
            ""
            "#{?mouse_word,Search For #[underscore]#{=/9/...:mouse_word},}" C-r "{ if-shell -F \"#{?#{m/r:(copy|view)-mode,#{pane_mode}},0,1}\" \"copy-mode -t=$pane\" ; send-keys -X -t \"$pane\" search-backward -- \"#{q:mouse_word}\" }"
            "#{?mouse_word,Type #[underscore]#{=/9/...:mouse_word},}" C-y "{ copy-mode -q ; send-keys -l \"#{q:mouse_word}\" }"
            "#{?mouse_word,Copy #[underscore]#{=/9/...:mouse_word},}" c "{ copy-mode -q ; set-buffer \"#{q:mouse_word}\" }"
            "#{?mouse_line,Copy Line,}" l "{ copy-mode -q ; set-buffer \"#{q:mouse_line}\" }"
            ""
            "#{?mouse_hyperlink,Type #[underscore]#{=/9/...:mouse_hyperlink},}" C-h "{ copy-mode -q ; send-keys -l \"#{q:mouse_hyperlink}\" }"
            "#{?mouse_hyperlink,Copy #[underscore]#{=/9/...:mouse_hyperlink},}" h "{ copy-mode -q ; set-buffer \"#{q:mouse_hyperlink}\" }"
            ""
            "#{?#{!:#{pane_floating_flag}},Horizontal Split,}" h "{ split-window -h -c \"#{pane_current_path}\" }"
            "#{?#{!:#{pane_floating_flag}},Vertical Split,}" v "{ split-window -v -c \"#{pane_current_path}\" }"
            ""
            "#{?#{&&:#{!:#{pane_floating_flag}},#{>:#{window_panes},1}},Swap Up,}" u "{ swap-pane -U }"
            "#{?#{&&:#{!:#{pane_floating_flag}},#{>:#{window_panes},1}},Swap Down,}" d "{ swap-pane -D }"
            "#{?pane_marked_set,,-}Swap Marked" s "{ swap-pane }"
            ""
            Kill X "{ kill-pane }"
            Respawn R "{ respawn-pane -k }"
            "#{?pane_marked,Unmark,Mark}" m "{ select-pane -m }"
            "#{?#{>:#{window_panes},1},,-}#{?window_zoomed_flag,Unzoom,Zoom}" z "{ resize-pane -Z }"
        )
        "${menu[@]}"
    elif (( ax >= ay && dx > 0 )); then
        tmux split-window -h -c "#{pane_current_path}" -t "$pane"
    elif (( ay > ax && dy > 0 )); then
        tmux split-window -v -c "#{pane_current_path}" -t "$pane"
    fi
}

case "$1" in
    down) down "$@" ;;
    up) up "$@" ;;
esac
