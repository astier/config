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
alias pacman='sudo pacman'

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
alias gcmp='git commit -m && git push'
alias gcam='git commit -am'
alias gcamp='git commit -am && git push'
alias gpl='git pull'

# Misc
alias ..='cd ..'
alias sa='source activate'
alias sd='source deactivate'
alias m='sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias v='nvim'
