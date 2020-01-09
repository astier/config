#!/usr/bin/env sh

file=$(fzf)
if [ "$file" ]; then
    $EDITOR "$file"
else
    tmux kill-pane
fi
