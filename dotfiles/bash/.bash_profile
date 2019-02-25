#!/usr/bin/env bash

export PATH=$PATH:~/miniconda3/bin:~/bin
export EDITOR=nvim
export DOTFILES=~/Projects/dotfiles/dotfiles

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
    startx
fi
