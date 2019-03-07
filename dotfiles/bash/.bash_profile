#!/usr/bin/env bash

export PATH=$PATH:~/miniconda3/bin:~/.local/bin
export EDITOR=nvim
export BROWSER=firefox
export DOTFILES=~/Projects/dotfiles/dotfiles

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
	startx
fi
