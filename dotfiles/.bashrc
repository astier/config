#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Settings
HISTCONTROL=erasedups
PS1='\[\e[32m\][\W]\$\[\e[m\] '
set -o vi

# Defaults
alias df='df -h'
alias grep='grep --color'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color --group-directories-first -h'

# Dotfiles
alias cfb='$EDITOR ~/.bashrc && . ~/.bashrc'

# Git
alias ga='git add'
alias gaa='git add --all'
alias gl='git log'
alias glo='git log --oneline'
alias gs='git status'
alias gp='git push'
alias gd='git diff'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gpl='git pull'

# Misc
alias ..='cd ..'
alias sa='source activate'
alias sd='source deactivate'
alias m='sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias pacman='sudo pacman'
alias v='nvim'
