#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Prompt
. ~/.config/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GREEN="\[\e[32m\]"
WHITE="\[\e[m\]"
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')] ${WHITE}"

# Settings
HISTCONTROL=ignoreboth
set -o vi
shopt -s autocd cdspell

# Defaults
alias cal='cal -m'
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -h"
alias pacman="sudo pacman"
alias rm="rm -fr"
cd() { builtin cd "$@" && ls -A; }

# Shortcuts
alias -- -="cd -"
alias -- ,="cd .."
alias c="cd"
alias d="clear"
alias dd="cd; clear"
alias l="ls -A"
alias ll="ls -Al"
alias m="mv"
alias mai="sudo make install clean"
alias md="mkdir"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias p="cp"
alias pa="patch -p1 < "
alias r="rm"
alias sa="source activate"
alias sd="conda deactivate"
alias u='yay'

# Directories
alias ja="cd ~/Projects/arch/"
alias jd="cd \$DOTFILES"
alias jdm="cd ~/Projects/dmenu/"
alias jdo="cd ~/Downloads/"
alias jdw="cd ~/Projects/dwm/"
alias jmc="cd ~/Dropbox/ISY/S3/MYO/code/"
alias jmr="cd ~/Dropbox/ISY/S3/MYO/report/"
alias jn="cd ~/Dropbox/Notes/"
alias jp="cd ~/Projects/"
alias jsc="cd ~/Projects/scripts/scripts/"
alias jsi="cd ~/Projects/sites/"
alias jst="cd ~/Projects/st/"
alias jsx="cd ~/Projects/sxiv/"
alias jw="cd ~/Dropbox/Pictures/Wallpapers/"

# Files
alias o="open"
alias oa="\$EDITOR ~/Projects/arch/arch_desktop.sh"
alias ob="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias obp="\$EDITOR \$DOTFILES/bash/.bash_profile"
alias on="\$EDITOR ~/Dropbox/Notes/notes"
alias ov="\$EDITOR \$DOTFILES/nvim/init.vim"
alias ox="\$EDITOR \$DOTFILES/xorg/.xinitrc"

# Git
alias g="git log --all --graph --decorate --oneline -n16"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbd="git branch -d"
alias gbv="git branch -v"
alias gbvv="git branch -vv"
alias gc="git commit"
alias gcam="git commit -am"
alias gcl="git clone"
alias gcm="git commit -m"
alias gcn="git clean -f"
alias gd="git diff"
alias gg="git log --all --graph --decorate --oneline"
alias gl="git log --date=auto:human"
alias glo="git log --oneline"
alias go-="git checkout --"
alias go="git checkout"
alias gob="git checkout -b"
alias gpa="git format-patch --stdout HEAD^ >"
alias gpl="git pull"
alias gps="git push"
alias grh="git reset --hard"
alias grr="git reset --hard; git clean -f"
alias gs="git status -s"
alias gsm="git send-email --subject-prefix="" --to"
