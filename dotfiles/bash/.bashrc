[[ $- != *i* ]] && return

# Prompt
. ~/.config/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
num_jobs() {
	NUM_JOBS=$(jobs | wc -l)
	[[ "$NUM_JOBS" -gt 0 ]] && echo " $NUM_JOBS"
}
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')${RED}\$(num_jobs)${GREEN}] ${NO_COLOR}"

# Settings
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="cal:df:history:poweroff:pwd:reboot:top"
HISTIGNORE+=":bd:d:c:f:i:l:lb:ll:ma:mai:ml:sd:x:xc:xm:xp:y"
HISTIGNORE+=":,:-:a:aa:aad:ab:ac:ad:adb:adm:ado:adw:ai:al:am:an:ap:asc:ase:ast:av:aw:ax"
HISTIGNORE+=":gaa:gd:gs:gca:g:gg:gl:gps:gpsf:gpl:gcn:grh:grr"
set -o noclobber vi
shopt -s autocd cdspell checkwinsize histappend

# Defaults
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -Ah"
alias lsblk="lsblk -o name,fstype,label,size,mountpoint"
alias mkdir="mkdir -p"
alias mv="mv -i"
alias mount="sudo mount"
alias umount="sudo umount"
alias newsboat="newsboat -u ~/Dropbox/Documents/Misc/urls"
alias pacman="sudo pacman"
alias rm="rm -fr"
alias top="top -1 -u \$USER"

# Shortcuts
d() { if [ "$#" == 0 ]; then clear; else rm "$@"; fi }
alias bd="b -d"
alias c="cat"
alias f="fg"
alias i="iwctl"
alias l="ls"
alias lb="lsblk"
alias ll="ls -l"
alias m="mv"
alias ma="make; make clean"
alias mai="sudo make install clean"
alias md="mkdir"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias n="newsboat"
alias p="cp"
alias py="python"
alias sa="source activate"
alias sd="conda deactivate"
alias t="touch"
alias xc="x -c"
alias xm="x -m"
alias xp="x -p"
alias y='yay'

cd() { if [ "$#" == 0 ]; then builtin cd && clear; else builtin cd "$@" && ls; fi }

a() {
	if [ "$#" == 0 ]; then cd
	elif [ "$#" == 1 ] && [ -f "$1" ]; then xdg-open "$@"
	elif [ "$#" == 1 ] && [ -d "$1" ]; then cd "$@" || exit
	else nvim "$@"; fi
}

# Bookmarks (ar and as already existing commands)
alias -- ,="cd .."
alias -- -="cd -"
alias aa="cd ~/Projects/arch"
alias aad="\$EDITOR ~/Projects/arch/arch_desktop.sh"
alias ab="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias abp="\$EDITOR \$DOTFILES/bash/.bash_profile"
alias ac="cd ~/.config/"
alias ad="cd \$DOTFILES"
alias adb="cd ~/Dropbox"
alias adm="cd ~/Projects/dmenu"
alias ado="cd ~/Downloads"
alias adw="cd ~/Projects/dwm"
alias ai="cd ~/Dropbox/ISY/S4"
alias al="cd ~/.local/share"
alias am="cd ~/Dropbox/ISY/S3/MYO"
alias an="cd ~/Dropbox/Notes"
alias ann="\$EDITOR ~/Dropbox/Notes/notes"
alias anp="\$EDITOR ~/Dropbox/Notes/pms.md"
alias ap="cd ~/Projects"
alias asc="cd ~/Projects/scripts/scripts"
alias ase="cd ~/Dropbox/ISY/S4/ASE"
alias ast="cd ~/Projects/st"
alias au="\$EDITOR ~/Dropbox/Documents/Misc/urls"
alias av="\$EDITOR \$DOTFILES/nvim/init.vim"
alias aw="cd ~/Dropbox/Pictures/Wallpapers"
alias ax="\$EDITOR \$DOTFILES/xorg/.xinitrc"

# Git
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbd="git branch -D"

alias gcl="git clone"
alias gd="git diff"
alias gs="git status -s"

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
alias gpsf="git push -f"
alias gpl="git pull"

alias gcn="git clean -f"
alias grh="git reset --hard"
alias grs="git reset --soft"
alias grr="git reset --hard; git clean -f"

##### AMiRo ENVIRONMENT CONFIGURATION #####
# DO NOT EDIT THESE LINES MANUALLY!
export PATH=$PATH:/home/aleks/Projects/ase/gcc-arm-embedded
##### AMiRo ENVIRONMENT CONFIGURATION #####

