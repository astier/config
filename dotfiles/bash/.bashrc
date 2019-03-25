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
HISTCONTROL=ignoreboth:erasedups
set -o vi
shopt -s autocd cdspell checkwinsize histappend

# Defaults
alias cal='cal -m'
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -Ah"
alias lsblk="lsblk -o name,fstype,label,size,mountpoint"
alias mv="mv -i"
alias mount="sudo mount"
alias umount="sudo umount"
alias n="newsboat -u ~/Dropbox/Documents/Misc/urls"
alias pacman="sudo pacman"
alias rm="rm -fr"
alias top="top -1 -u \$USER"

cd() {
	if [ "$1" == "" ]; then
		builtin cd && clear
	else
		builtin cd "$@" && ls
	fi
}

# Shortcuts
alias -- ,="cd .."
alias -- -="cd -"
alias c="cd"
alias d="clear"
alias l="ls"
alias ll="ls -l"
alias lb="lsblk"
alias m="mv"
alias mai="sudo make install clean"
alias md="mkdir"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias p="cp"
alias pa="patch -p1 < "
alias r="rm"
alias sa="source activate"
alias sd="conda deactivate"
alias y='yay'

# Directories
alias ja="cd ~/Projects/arch/"
alias jc="cd ~/.config/"
alias jl="cd ~/.local/share/"
alias jd="cd \$DOTFILES"
alias jdb="cd ~/Dropbox/"
alias jdm="cd ~/Projects/dmenu/"
alias jdo="cd ~/Downloads/"
alias jdw="cd ~/Projects/dwm/"
alias jmc="cd ~/Dropbox/ISY/S3/MYO/code/"
alias jmr="cd ~/Dropbox/ISY/S3/MYO/report/"
alias jn="cd ~/Dropbox/Notes/"
alias jp="cd ~/Projects/"
alias js="cd ~/Projects/scripts/scripts/"
alias jst="cd ~/Projects/st/"
alias jw="cd ~/Dropbox/Pictures/Wallpapers/"

# Files
alias o="open"
alias oa="\$EDITOR ~/Projects/arch/arch_desktop.sh"
alias ob="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias obp="\$EDITOR \$DOTFILES/bash/.bash_profile"
alias on="\$EDITOR ~/Dropbox/Notes/notes"
alias ou="\$EDITOR ~/Dropbox/Documents/Misc/urls"
alias ov="\$EDITOR \$DOTFILES/nvim/init.vim"
alias ox="\$EDITOR \$DOTFILES/xorg/.xinitrc"

# Git
alias ga="git add --all"
alias gaa="git add"

alias gb="git branch"
alias gbd="git branch -d"

alias gs="git status -s"
alias gcl="git clone"
alias gd="git diff"

alias gc="git commit -am"
alias gca="git commit -m"
alias gcam="git commit"

alias g="git log --all --graph --decorate --oneline -n16"
alias gg="git log --all --graph --decorate --oneline"
alias gl="git log --date=auto:human"

alias go-="git checkout --"
alias go="git checkout"

alias gp="git push"
alias gpl="git pull"

alias gcn="git clean -f"
alias grh="git reset --hard"
alias grr="git reset --hard; git clean -f"
