#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Settings
HISTCONTROL=ignoreboth
PS1="\[\e[32m\][\W]\$\[\e[m\] "
set -o vi

# Defaults
alias df="df -h"
alias grep="grep --color"
alias la="ls -A"
alias ll="ls -l"
alias ls="ls --color --group-directories-first -h"
alias pacman="sudo pacman"

# Dotfiles
alias dot="/usr/bin/git --git-dir=$HOME/Projects/dot/ --work-tree=/"
alias cfb="$EDITOR ~/.bashrc && . ~/.bashrc"

# Git
alias ga="git add"
alias gaa="git add --all"
alias gl="git log"
alias glo="git log --oneline"
alias gs="git status"
alias gp="git push"
alias gd="git diff"
alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gpl="git pull"

# Misc
alias c="clear"
alias sa="source activate"
alias sd="source deactivate"
alias m="sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias v="nvim"

# Bookmarks
alias ..="cd .."
alias ...="cd /"
alias ja="cd ~/Projects/arch-installer/"
alias js="cd ~/Projects/scripts/"
alias jd="cd ~/Projects/dotfiles/"
alias jm="cd ~/Projects/multi-desire-planer/"
cd() { builtin cd "$@" && ls -A; }
