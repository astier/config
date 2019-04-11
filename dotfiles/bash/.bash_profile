#!/usr/bin/env bash

export PATH=$PATH:~/miniconda3/bin:~/.local/bin
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export DOTFILES=~/Projects/dotfiles/dotfiles

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]] && startx
