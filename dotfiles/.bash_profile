#!/usr/bin/env bash

export PATH=$PATH:~/miniconda3/bin:~/bin
export EDITOR=vi

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
    startx
fi
