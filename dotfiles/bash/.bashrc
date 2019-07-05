#!/usr/bin/env bash

[[ $- != *i* ]] && return

# PROMPT
. ~/.config/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
num_jobs() { NUM_JOBS=$(jobs | wc -l) && [[ "$NUM_JOBS" -gt 0 ]] && echo " $NUM_JOBS"; }
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')${RED}\$(num_jobs)${GREEN}] ${NO_COLOR}"

# SETTINGS
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="df:poweroff:reboot"
HISTIGNORE+=":c:d:dl:e:f:i:l:lb:ll:ma:ml:n:py:sd:sl:sp:sr:t:ta:tl:uu:x:xc:xm:xp:y"
HISTIGNORE+=":,:-:a:aa:ac:ad:ao:ai:al:am:ap:asc:ase:ax"
HISTIGNORE+=":gaa:gs:gc:gca:g:gg:gl:go-:gcn"
set -o vi
shopt -s autocd cdspell checkwinsize histappend

# TEMPORARY
export PATH=$PATH:~/projects/ase/gcc-arm-embedded
export PATH=~/.yarn/bin:~/.config/yarn/global/node_modules/.bin:$PATH
[ -f /opt/ros/melodic/setup.bash ] && . /opt/ros/melodic/setup.bash
alias maf="make && make flash && (gtkterm -c AMiRo &)"
alias ros="cd ~/projects/ase/catkin_ws && . devel/setup.sh"

# DEFAULTS
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
alias shfmt="shfmt -ci -sr -p -s"
alias rm="rm -fr"
alias top="top -1 -u \$USER"
alias umount="sudo umount"

# FUNCTIONS
cd() { if [ "$#" == 0 ]; then builtin cd || return; else builtin cd "$@" && ls; fi; }
d() { if [ "$#" == 0 ]; then clear; else rm "$@"; fi; }
di() { $BROWSER https://www.dict.cc/?s="$1"; }
flash() { sudo dd bs=4M if="$2" of="$1" status=progress oflag=sync; }

# SHORTCUTS
alias c="cat"
alias da="cd; clear"
alias dl="clear; ls"
alias e="exit"
alias f="fg"
alias l="ls"
alias lb="lsblk"
alias ll="ls -l"
alias m="mv"
alias ma="make; make clean"
alias mai="sudo make install clean"
alias md="mkdir"
alias p="cp"
alias pa="patch -p1 <"
alias py="python"
alias r="sudo \$(fc -ln -1)"
alias s="sudo"
alias to="touch"
alias u="sudo reflector -p https -f16 -l8 --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && echo && yay"

# TMUX
alias t="tmux a -t 0 || tmux new -c ~ -s 0"
alias ta="tmux a -t"
alias tl="tmux ls"
alias tn="tmux new -s"

# X
alias xc="x -c; x"
alias xm="x -m"
alias xp="x -p"

# POWER-MANAGEMENT
alias sd="systemctl suspend"
alias sl="slock"
alias sp="poweroff"
alias sr="reboot"

# APERIRE. Similar to xdg-open but does what I actually want and is faster.
a() {
	[ "$#" == 0 ] && cd && ls && return
	[ -d "$1" ] && cd "$@" && return
	[ ! -f "$1" ] && [ ! -d "$1" ] && echo "Can't find: $*" && return
	mimetype=$(file -bL --mime-type "$1")
	mime=$(echo "$mimetype" | cut -d/ -f1)
	case $mime in
		"text") $EDITOR "$@" && return ;;
		"image") $BROWSER "$@" && return ;;
		"video") $BROWSER "$@" && return ;;
		"audio") $BROWSER "$@" && return ;;
	esac
	case $mimetype in
		"application/json") $EDITOR "$@" ;;
		"inode/x-empty") $EDITOR "$@" ;;
		"application/pdf") $BROWSER "$@" ;;
		*) echo No association with mimetype: "$mimetype" >&2 ;;
	esac
}

# BOOKMARKS (ar and as are already existing commands)
alias -- ,="cd -"
alias ac="cd ~/.config"
alias aca="cd ~/.cache"
alias af="\$EDITOR"
alias ao="cd ~/Downloads"
alias al="cd ~/.local/share"
alias asn="cd ~/.local/share/nvim/plugins/vim-snippets/UltiSnips"
alias att="\$EDITOR /tmp/scratch"

alias i="tstatus"
alias ii="networkctl"
alias iof="sudo ip link set dev wlan0 down"
alias ion="sudo ip link set dev wlan0 up"

alias add="cd ~/Dropbox"
alias api="cd ~/Dropbox/pictures"

alias au="cd ~/Dropbox/uni"
alias ase="cd ~/Dropbox/uni/s4/ase/exercises/2"
alias myo="cd ~/Dropbox/uni/s3/myo"
alias rdm="cd ~/Dropbox/uni/s3/rdm"

alias an="cd ~/Dropbox/Notes"
alias anb="cd ~/Dropbox/notes && \$EDITOR bugs"
alias ani="cd ~/Dropbox/notes && \$EDITOR ideas"
alias anl="cd ~/Dropbox/notes && \$EDITOR learn"
alias ann="cd ~/Dropbox/notes && \$EDITOR notes"
alias anp="cd ~/Dropbox/notes && \$EDITOR pms.md"
alias at="cd ~/Dropbox/notes && \$EDITOR todo"

alias ap="cd ~/projects"
alias aa="cd ~/projects/arch"
alias aaa="cd ~/projects/arch && \$EDITOR base.sh desktop.sh"
alias aab="cd ~/projects/arch && \$EDITOR base.sh"
alias aad="cd ~/projects/arch && \$EDITOR desktop.sh"
alias asc="cd ~/projects/scripts/scripts"
alias ast="cd ~/projects/st"

alias asu="cd ~/projects/suckless"
alias adm="cd ~/projects/suckless/dmenu"
alias adw="cd ~/projects/suckless/dwm"
alias asi="cd ~/projects/suckless/sites"
alias ast="cd ~/projects/suckless/st"

alias ad="cd ~/projects/dotfiles/dotfiles"
alias ab="\$EDITOR ~/projects/dotfiles/dotfiles/bash/.bashrc && . ~/.bashrc"
alias av="\$EDITOR ~/projects/dotfiles/dotfiles/nvim/init.vim"
alias ax="\$EDITOR ~/projects/dotfiles/dotfiles/.xinitrc"

# GIT
alias ga="git add"
alias gaa="git add --all"
alias gam="git commit --amend"
alias gb="git branch"
alias gbd="git branch -D"
alias gbr="git remote -v | grep -P \(push\) | cut -d ' ' -f 1 | cut -f 2 | xargs -r \$BROWSER"
alias gcl="git clone"
alias gfp="git format-patch --stdout HEAD^ >"
alias gs="git status -s"
alias gd="git diff"

alias gc="git commit"
alias gca="git add --all && git commit"
alias gcr="git commit -am tmp && git rebase -i HEAD~2"
alias gcp="git add --all && git commit && git push"

g() { n=16; [ "$#" != 0 ] && n=$1; git log --all --graph --decorate --oneline -n"$n"; }
alias gg="git log --all --graph --decorate --oneline"
alias ggg="git log --oneline --grep"
alias gl="git log --date=auto:human"
alias glg="git log --grep"
alias gso="git show"

alias go="git checkout"
alias gob="git checkout -b"
alias gom="git checkout master"

alias gf="git fetch"
alias gm="git merge"
alias gpl="git pull"
alias gps="git push"
alias gpsf="git push -f"

grh() { n=0; [ "$#" != 0 ] && n=$1; git reset --hard HEAD~"$n"; }
alias gcn="git clean -f"
alias grb="git rebase -i"
alias grr="git reset --hard; git clean -f"
alias grq="git rebase -i HEAD~2"
alias grs="git reset --soft"
alias grv="git revert"
