#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Settings
HISTCONTROL=ignoreboth
PS1="\[\e[32m\][\W]\$\[\e[m\] "
set -o vi

# Defaults
alias df="df -h"
alias grep="grep --color"
alias l="ls -A"
alias ll="ls -l"
alias ls="ls --color --group-directories-first -h"
alias pacman="sudo pacman"
alias rm="rm -fr"

# Bookmarks
alias ...="cd /"
alias ..="cd .."
alias jn="cd ~/Dropbox/Notes/"
cd() { builtin cd "$@" && ls -A; }

# Dotfiles
alias ob="$EDITOR ~/.bashrc && . ~/.bashrc"
alias on="$EDITOR ~/Dropbox/Notes/notes"

# Templates
TMP="~/Projects/templates"
alias tla="cp $TMP/latex/article.tex ."
alias tlb="cp $TMP/latex/beamer.tex ."

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
alias go="git checkout"
alias go-="git checkout --"

# Misc
alias c="clear"
alias m="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias sa="source activate"
alias sd="conda deactivate"
alias v="nvim"
