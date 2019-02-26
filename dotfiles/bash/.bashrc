#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Bash
HISTCONTROL=ignoreboth
PS1="\[\e[32m\][\W]\$\[\e[m\] "
set -o vi
shopt -s autocd cdspell

# Defaults
alias cal='cal -m'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -h"
# alias maim="maim ~/Dropbox/Pictures/$(date +%s).png"
alias pacman="sudo pacman"
alias rm="rm -fr"
cd() { builtin cd "$@" && ls -A; }

# Directories
alias jp="cd ~/Projects/"
alias jdo="cd ~/Downloads/"
alias ja="cd ~/Projects/arch-installer/"
alias jd="cd $DOTFILES"
alias jdm="cd ~/Projects/dmenu/"
alias jdw="cd ~/Projects/dwm/"
alias jst="cd ~/Projects/st/"
alias jsc="cd ~/Projects/scripts/scripts/"
alias jm="cd ~/Dropbox/ISY/S3/MYO/"
alias jn="cd ~/Dropbox/Notes/"
alias jw="cd ~/Dropbox/Pictures/Wallpapers/"

# Files
alias ob="$EDITOR $DOTFILES/bash/.bashrc && . ~/.bashrc"
alias obp="$EDITOR $DOTFILES/bash/.bash_profile"
alias ox="$EDITOR $DOTFILES/xorg/.xinitrc"
alias ov="$EDITOR $DOTFILES/nvim/init.vim"
alias oa="$EDITOR ~/Projects/arch-installer/arch_desktop.sh"
alias on="$EDITOR ~/Dropbox/Notes/notes"

# Templates
TMP="$HOME/Projects/templates"
alias tla="cp $TMP/latex/article.tex ."
alias tlb="cp $TMP/latex/beamer.tex ."

# Git
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbd="git branch -d"
alias gbv="git branch -v"
alias gbvv="git branch -vv"
alias gc="git commit"
alias gcl="git clone"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gd="git diff"
alias gl="git log --date=auto:human"
alias glo="git log --oneline"
alias gg="git log --all --graph --decorate --oneline -n16"
alias g="git log --all --graph --decorate --oneline"
alias go-="git checkout --"
alias go="git checkout"
alias gob="git checkout -b"
alias gp="git push"
alias gpl="git pull"
alias grh="git reset --hard"
alias gcn="git clean -f"
alias gs="git status"
alias gpa="git format-patch --stdout HEAD^ > "

# Misc
alias -- -="cd -"
alias c="cd"
alias cl="clear"
alias l="ls -A"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias mai="sudo make install clean"
alias p="patch -p1 < "
alias sa="source activate"
alias sd="conda deactivate"
alias u='yay'
alias v="nvim"
