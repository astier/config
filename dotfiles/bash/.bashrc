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
HISTIGNORE="df:poweroff:reboot"
HISTIGNORE+=":c:d:dl:f:i:ii:l:lb:ll:ma:maf:mai:ml:py:x:xc:xm:xp:y"
HISTIGNORE+=":,:-:a:aa:ab:ac:ad:adb:ado:adw:ai:al:am:an:ann:anp:ap:asc:ase:ast:av:ax"
HISTIGNORE+=":gaa:gd:gs:gc:gca:g:gg:gl:go-:gps:gpsf:gpl:gcn:grr"
set -o noclobber vi
shopt -s autocd cdspell checkwinsize histappend

# Defaults
alias cal="cal -m"
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -Ah"
alias lsblk="lsblk -o name,label,mountpoint,fstype,size"
alias mkdir="mkdir -p"
alias mount="sudo mount"
alias mv="mv -i"
alias pacman="sudo pacman"
alias rm="rm -fr"
alias top="top -1 -u \$USER"
alias umount="sudo umount"

# Shortcuts
d() { if [ "$#" == 0 ]; then clear; else rm "$@"; fi }
alias c="cat"
alias da="cd; clear"
alias dl="clear; ls"
alias f="fg"
alias ii="iwctl"
alias l="ls"
alias lb="lsblk"
alias ll="ls -l"
alias m="mv"
alias ma="make; make clean"
alias maf="make && make flash && gtkterm -c AMiRo"
alias mai="sudo make install clean"
alias md="mkdir"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias p="cp"
alias pqet="pacman -Qet"
alias py="python"
alias s="sudo"
alias sd="systemctl suspend"
alias sl="slock"
alias sp="poweroff"
alias sr="reboot"
alias t="touch"
alias xc="x -c"
alias xm="x -m"
alias xp="x -p"
alias y='yay && pacman -U /var/cache/pacman/pkg/iwd-0.16-4-x86_64.pkg.tar.xz'

cd() { builtin cd "$@" && ls; }

a() {
	if [ "$#" == 0 ]; then cd || exit 1
	elif [ "$#" == 1 ] && [ -f "$1" ]; then xdg-open "$@"
	elif [ "$#" == 1 ] && [ -d "$1" ]; then cd "$@" || exit 1
	else nvim "$@"; fi
}

# Bookmarks (ar and as already existing commands)
alias -- ,="cd .."
alias -- -="cd -"
alias aa="cd ~/Projects/arch"
alias ab="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias ac="cd ~/.config/"
alias ad="cd \$DOTFILES"
alias adb="cd ~/Dropbox"
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
alias at="\$EDITOR /tmp/scratch"
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

alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gcm="git commit -m"
gcp() { git add --all && git commit -m "$1" && git push; }

alias g="git log --all --graph --decorate --oneline -n16"
alias gg="git log --all --graph --decorate --oneline"
alias ggg="git log --oneline --grep"
alias gl="git log --date=auto:human"
alias glg="git log --grep"

alias go="git checkout"
alias gob="git checkout -b"

alias gpl="git pull"
alias gps="git push"
alias gpsf="git push -f"

alias gcn="git clean -f"
alias grh="git reset --hard"
alias grr="git reset --hard; git clean -f"
alias grs="git reset --soft"
