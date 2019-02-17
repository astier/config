#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Bash
HISTCONTROL=ignoreboth
PS1="\[\e[32m\][\W]\$\[\e[m\] "
set -o vi
shopt -s autocd cdspell

# Scripts & Functions
. /usr/share/bashmarks/bashmarks.sh
cd() { builtin cd "$@" && ls -A; }

# Defaults
alias cal='cal -m'
alias df="df -h"
alias dfx="df -hx tmpfs"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -h"
alias la="ls -A"
alias ll="ls -l"
alias pacman="sudo pacman"
alias rm="rm -fr"

# Dotfiles
alias ob="$EDITOR ~/.bashrc && . ~/.bashrc"
alias obp="$EDITOR ~/.bash_profile"
alias on="$EDITOR ~/Dropbox/Notes/notes"

# Templates
TMP="$HOME/Projects/templates"
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
alias md="mkdir"
alias u='yay'
alias v="nvim"
