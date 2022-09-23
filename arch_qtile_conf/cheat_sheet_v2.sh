#!/usr/bin/env bash

# variables
languages=$(echo "python lua rust golang bash" | tr " " "\n")
core_utils=$(echo "find xargs sed awk git helm docker docker-compose" | tr " " "\n")

# fzf menu
selected=$(printf "$languages\n$core_utils" | fzf)
echo "selected: $selected"

# if language is selected
if printf $languages$ | grep -qs $selected; then
  read -p "query: " query
  query=$(echo $query | tr ' ' '+')
  if [ $query == "_h" ]; then
    opts=$(echo "$(curl cht.sh/$selected/:list | fzf)")
    tmux neww bash -c "curl cht.sh/$selected/$opts & while [ : ]; do sleep 1; done"
  else
    tmux neww bash -c "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
  fi

# if core_utils is selected
else
  tmux neww bash -c "curl cht.sh/$selected~$query | less"
fi
