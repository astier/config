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
num_jobs() {
	num_jobs=$(jobs | wc -l)
	[[ "$num_jobs" -gt 0 ]] && echo " $num_jobs"
}
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')\$(num_jobs)] ${WHITE}"

# Settings
HISTCONTROL=ignoreboth:erasedups
set -o noclobber vi
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
alias pacman="sudo pacman"
alias rm="rm -fr"
alias top="top -1 -u \$USER"
alias zip="zip -r"

cd() {
	if [ "$#" == 0 ]; then
		builtin cd || exit
		clear
	else
		builtin cd "$@" && ls
	fi
}

# Shortcuts
alias c="cp"
alias d="clear"
alias f="fg"
alias l="ls"
alias ll="ls -l"
alias lb="lsblk"
alias m="mv"
alias ma="make; make clean"
alias mai="sudo make install clean"
alias md="mkdir"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias p="python"
alias r="rm"
alias sa="source activate"
alias sd="conda deactivate"
alias y='yay'

# Directories
alias -- ,="cd .."
alias -- -="cd -"
alias j="cd"
alias ja="cd ~/Projects/arch/"
alias jas="cd ~/Dropbox/ISY/S4/ASE/"
alias jb="cd ~/Dropbox/"
alias jc="cd ~/.config/"
alias jd="cd \$DOTFILES"
alias jdm="cd ~/Projects/dmenu/"
alias jdw="cd ~/Projects/dwm/"
alias jl="cd ~/.local/share/"
alias ji="cd ~/Dropbox/ISY/"
alias jm="cd ~/Dropbox/ISY/S3/MYO/"
alias jn="cd ~/Dropbox/Notes/"
alias jo="cd ~/Downloads/"
alias jp="cd ~/Projects/"
alias js="cd ~/Projects/scripts/scripts/"
alias jst="cd ~/Projects/st/"
alias jw="cd ~/Dropbox/Pictures/Wallpapers/"

# Files
alias o="open"
alias oa="\$EDITOR ~/Projects/arch/arch_desktop.sh"
alias oab="\$EDITOR ~/Projects/arch/arch_base.sh"
alias ob="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias obp="\$EDITOR \$DOTFILES/bash/.bash_profile"
alias on="\$EDITOR ~/Dropbox/Notes/notes"
alias ov="\$EDITOR \$DOTFILES/nvim/init.vim"
alias ox="\$EDITOR \$DOTFILES/xorg/.xinitrc"

# Git
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbd="git branch -d"

alias gcl="git clone"
alias gd="git diff"
alias gs="git status -s"

alias gcc="git commit"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gcm="git commit -m"
gc() { git add --all; git commit -m "$1" && git push; }

alias g="git log --all --graph --decorate --oneline -n16"
alias gg="git log --all --graph --decorate --oneline"
alias gl="git log --date=auto:human"

alias go-="git checkout --"
alias go="git checkout"
alias gob="git checkout -b"

alias gps="git push"
alias gpl="git pull"

alias gcn="git clean -f"
alias grh="git reset --hard"
alias grs="git reset --soft"
alias grr="git reset --hard; git clean -f"

##### AMiRo ENVIRONMENT CONFIGURATION #####
# DO NOT EDIT THESE LINES MANUALLY!
export PATH=$PATH:/home/aleks/Dropbox/ISY/S4/ASE/gcc-arm-embedded
##### AMiRo ENVIRONMENT CONFIGURATION #####

