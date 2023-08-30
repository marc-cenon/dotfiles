
#!/bin/bash

# if dir provided use it or use default
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/ -mindepth 1 -maxdepth 1 -type d | fzf)
fi

# if nothing, quit
if [[ -z $selected ]]; then
    exit 0
fi

#filter folder name
selected_name=$(basename "$selected" | tr . _)

#check if tmux is running
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

#test git stash 2
