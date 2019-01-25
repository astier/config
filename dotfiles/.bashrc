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
alias rm="rm -fr"

# Bookmarks
alias ...="cd /"
alias ..="cd .."
alias ja="cd ~/Projects/arch-installer/"
alias jd="cd ~/Projects/dotfiles/dotfiles/"
alias jm="cd ~/Projects/multi-desire-planer/"
alias jn="cd ~/Dropbox/Notes/"
alias js="cd ~/Projects/scripts/"
alias jy="cd ~/Dropbox/ISY/S3/MYO/"
cd() { builtin cd "$@" && ls -A; }

# Dotfiles
alias ob="$EDITOR ~/.bashrc && . ~/.bashrc"
alias on="$EDITOR ~/Dropbox/Notes/notes"

# Git
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gd="git diff"
alias gl="git log"
alias glo="git log --oneline"
alias gp="git push"
alias gpl="git pull"
alias gs="git status"

# Misc
alias c="clear"
alias m="sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias sa="source activate"
alias sd="source deactivate"
alias v="nvim"
