#!/usr/bin/env sh

clear
file=$(fzf)
if [ "$file" ]; then
    $EDITOR "$file"
else
    tmux kill-pane
fi
