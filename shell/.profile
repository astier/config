#!/usr/bin/env sh

export CONFIG="$HOME/repos/config"

EXPORTS=$CONFIG/shell/exports
[ -f "$EXPORTS" ] && . "$EXPORTS"

# AUTOSTART - TTY1
if [ "$(tty)" = /dev/tty1 ] && [ ! -f /tmp/tty1_started ]; then
    touch /tmp/tty1_started
    pulsemixer --unmute
    [ -f /usr/bin/sx ] && exec sx
fi

# THEME
if [ "$TERM" = linux ]; then
    BLACK=000000
    RED=cc241d
    GREEN=01a252
    YELLOW=d79921
    BLUE=5e81ac
    MAGENTA=a16a94
    CYAN=689d6a
    WHITE=a5a2a2
    BRIGHTBLACK=4c566a
    # NORMAL
    printf "\033]P0%s" "$BLACK"
    printf "\033]P1%s" "$RED"
    printf "\033]P2%s" "$GREEN"
    printf "\033]P3%s" "$YELLOW"
    printf "\033]P4%s" "$BLUE"
    printf "\033]P5%s" "$MAGENTA"
    printf "\033]P6%s" "$BRIGHTBLACK"
    printf "\033]P7%s" "$WHITE"
    # BRIGHT
    printf "\033]P8%s" "$BRIGHTBLACK"
    printf "\033]P9%s" "$RED"
    printf "\033]PA%s" "$GREEN"
    printf "\033]PB%s" "$YELLOW"
    printf "\033]PC%s" "$BLUE"
    printf "\033]PD%s" "$MAGENTA"
    printf "\033]PE%s" "$BRIGHTBLACK"
    printf "\033]PF%s" "$WHITE"
    clear
fi

# DEFAULTS
alias cryptsetup="sudo cryptsetup"
alias df="df -h"
alias du="du -h"
alias fd="fd --follow --hidden --exclude .git --color never"
alias fdisk="sudo fdisk"
alias gdisk="sudo gdisk"
alias grep="grep --color=auto"
alias less="less -FKRX"
alias ls="ls -Ahv --color=auto --group-directories-first"
alias mount="sudo mount"
alias sudo="sudo -E"
alias umount="sudo umount"
alias watch="watch --color"

rg() {
    if [ -t 1 ]; then
        command rg -p "$@" | less
    else
        command rg "$@"
    fi
}

# CPM
alias x="cpm"
alias xc="cpm -c"
alias xd="cpm -d"
alias xm="cpm -m"
alias xp="cpm -p"

# BOOKMARKS - FILES
alias fb="jumpopen \$CONFIG shell/.bashrc && . shell/.bashrc"
alias fbl="\$EDITOR ~/.config/bashrc_local && . ~/.config/bashrc_local"
alias fe="jumpopen \$CONFIG shell/exports && . shell/exports"
alias fn="jumpopen \$CONFIG nvim/init.vim"
alias fp="jumpopen \$CONFIG shell/.profile && . shell/.profile"
alias fu="nvim +'h user-manual | winc o'"
alias fx="jumpopen \$CONFIG sx/sxrc"
f() { if [ -d "$1" ]; then cd "$1" || return; else "$LAUNCHER" "$@"; fi }
jumpopen() { cd "$1" >/dev/null && shift && "$LAUNCHER" "$@" ; }

# BOOKMARKS - DATA
DATA=$HOME/data
alias jd="cd \$DATA"
alias jdc="cd \$DATA/config/"
alias jde="cd \$DATA/education"
alias jdj="cd \$DATA && j"
alias jdp="cd \$DATA/pictures"
alias ju="cd \$DATA/uni"
alias sn="rclone sync -Pv --stats-one-line --exclude .~* ~/data data:"
alias snn="rclone sync -Pv --stats-one-line data: ~/data"

# BOOKMARKS - HIDDEN
bookmarks=$HOME/data/config/bookmarks
[ -f "$bookmarks" ] && . "$bookmarks"
alias bm="\$EDITOR \$bookmarks && . \$bookmarks"

# BOOKMARKS - HOME
alias dl="cd ~/Downloads"
alias jb="cd \$HOME/.local/bin"
alias jca="cd \$XDG_CACHE_HOME"
alias jco="cd \$XDG_CONFIG_HOME"
alias jl="cd \$HOME/.local"
alias jsh="cd \$XDG_DATA_HOME"

# BOOKMARKS - NOTES
alias jn="cd \$DATA/notes"
alias n="jumpopen \$DATA/notes notes"
alias nb="jumpopen \$DATA/notes books"
alias ni="jumpopen \$DATA/notes ideas"
alias nl="jumpopen \$DATA/notes links"
alias nn="jumpopen \$DATA/notes newsboat"
alias np="jumpopen \$DATA/notes projects"
alias ns="jumpopen \$DATA/notes study"
alias rss="newsboat -u \$DATA/notes/newsboat"

# BOOKMARKS - REPOS
alias fa="jumpopen ~/repos/scripts arch.sh"
alias fv="jumpopen ~/repos/vlugins README.md"
alias jc="cd ~/repos/config"
alias jcf="cd ~/repos/config && f"
alias jr="cd ~/repos"
alias jrj="cd ~/repos && j"
alias js="cd ~/repos/scripts"
alias jsf="cd ~/repos/scripts && f"
alias jsi="cd ~/repos/sites/"
alias jt="cd ~/repos/st"
alias jv="cd ~/repos/vlugins"
alias jw="cd ~/repos/sswm"

j() {
    dir=$1
    if [ $# = 0 ]; then
        dir=$(ls-dirs | fzf)
    elif [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    [ -n "$dir" ] && cd "$dir" || return
}

# GIT
alias k="git log --all --graph --decorate --oneline --show-pulls -n24"
alias kk="nvim -c 'Flog -all' -c 1tabclose"
kg() { nvim -c "Flog -all -search=$1" -c 1tabclose; }

alias ka="git add"
alias kaa="git add --all"
alias kam="git commit --amend -v"
alias kap="git add -p"
alias kb="git branch -vv"
alias kba="git branch -avv"
alias kbd="git branch -D"
alias kbr="git remote -v | grep -P \(push\) | cut -d ' ' -f 1 | cut -f 2 | xargs -r \$BROWSER"
alias kd="git diff"
alias kdd="git diff | \$EDITOR"
alias kfp="git format-patch --stdout HEAD^"
alias kr="cd \$(git rev-parse --show-toplevel)"
alias krv="git remote -v"
alias ks="git status -bs"
alias kt="git tag"
kcl() { git clone "$@" "$(xsel -b | head -n1)"; }
ksf() { if [ $# = 0 ]; then git show | "$EDITOR"; else git show "$1" | "$EDITOR"; fi }

alias kc="git commit -v"
alias kca="git add --all && git commit -v"
alias kcp="git add --all && git commit -v && git push"
alias kcr="git commit -v -am tmp && git rebase -i HEAD~2"
alias kcrf="git commit -v -am tmp && git rebase -i HEAD~2 && git push -f"

alias ko="git checkout"
alias kop="git checkout -p"
alias kob="git checkout -b"
alias kom="git checkout master"

alias kf="git fetch"
alias kfr="git fetch \$(git remote | fzf)"
alias km="git merge"
alias kmm="git merge master"
alias kp="git push"
alias kpf="git push -f"
alias kpl="git pull"

alias kra="git rebase --abort"
alias krbr="git rebase -i --root"
alias krc="git rebase --continue"
alias krm="git rebase master"
krb() { n=16; [ "$1" ] && n=$1; git rebase -i HEAD~"$n"; }

alias kr.="git reset ."
alias krr="git reset --hard; git clean -f"
alias krs.="git reset --soft HEAD~1; git reset ."
alias krs="git reset --soft HEAD~1"
alias krv="git revert"
krh() { n=1; [ "$1" ] && n=$1; git reset --hard HEAD~"$n"; }

alias ksd="git stash drop"
alias ksl="git stash list"
alias ksp="git stash pop"
alias kst="git stash"

# INTERNET
alias ig="iwctl station wlan0 get-networks"
alias ir="sudo systemctl restart iwd.service"
alias is="iwctl station wlan0 scan"

# MEDIA
pm() { if [ $# = 0 ]; then mpv --no-video "$(xsel -ob)"; else mpv --no-video "$@"; fi }
pv() { if [ $# = 0 ]; then mpv "$(xsel -ob)"; else mpv "$@"; fi }
y() { youtube-dl "$@" "$(xsel -b | head -n1)"; }

# MMRDF
alias md="mkdir -pv"
m() { if [ $# = 0 ]; then make; else mv -iv "$@"; fi }
mx() { touch "$1" && chmod +x "$1"; }
mf() {
    for arg in "$@"; do
        dir=$(dirname "$arg")
        [ ! -d "$dir" ] && mkdir -pv "$dir"
        touch "$arg" && echo touch: created file \'"$arg"\'
    done
}

# MISC
alias a="execute"
alias as="echo Remapped to do nothing."
alias b="cd - >/dev/null && ls"
alias c="cd .."
alias clean="sudo pacman -Rns \$(pacman -Qttdq); sudo pacman -Sc; rm -fr \$XDG_CACHE_HOME/*; sudo rm -fr /var/log/journal/*; rm -fr \$XDG_DATA_HOME/nvim/view/*"
alias dus="du -s"
alias g="rg"
alias gw="g -w"
alias h="python"
alias i="pkg -i"
alias l="preview"
alias lb="lsblk -o name,label,mountpoint,fstype,size"
alias lk="sudo /usr/bin/lock"
alias lko="sudo /usr/bin/lock > /dev/null; sudo \$EDITOR \$XDG_CONFIG_HOME/lockrc; sudo /usr/bin/lock"
alias ll="ls -l"
alias lt="lint"
alias pa="patch -p1 <"
alias r="pkg -r"
alias re="sudo \$(fc -ln -1)"
alias s="echo \$(bstatus -c)B \| \$(volume ?)V \| \$(date +%H:%M) \| \$(date +%d.%m.%y)"
alias sc="scrot -s"
alias tmp="nvim +'set nospell' /tmp/scratch.md"
alias u="sudo reflector --protocol https --latest 8 --sort score --save /etc/pacman.d/mirrorlist && paru"
alias v="volume"
ar() { dir="$(basename "$1").tar.gz"; [ $# -gt 1 ] && shift; tar -czvf "$dir" "$@"; }
cd() { command cd "$@" && ls; }
d() { if [ $# = 0 ]; then exit; else realpath -s "$@" | sed 's/.*/"&"/' | xargs rm -fr; ls; fi }
flash() { sudo dd bs=4M if="$1" of="$2" status=progress oflag=sync; }
p() { if [ $# = 0 ]; then pwd | sed "s|$HOME|~|"; else cp -irv "$@"; fi }

# OPEN PROJECT-FILES
alias o="autopen"
alias ogi="\$EDITOR \$(git rev-parse --show-toplevel)/.gitignore"
alias ogm="\$EDITOR \$(git rev-parse --show-toplevel)/.gitmodules"
alias om="\$EDITOR Makefile"
alias or="[ -f README* ] && \$EDITOR README*"
alias os="\$EDITOR setup.sh"
alias ot="\$EDITOR todo"

autopen() {
    if [ -r "$(find . -maxdepth 1 -type f -name 'main\.*' -print -quit)" ]; then
        "$EDITOR" main.*
    elif [ -r setup.sh ]; then
        "$EDITOR" setup.sh
    elif [ -r config.h ]; then
        "$EDITOR" config.h
    else
        echo No appropriate file found.
    fi
}

# SYSTEM
alias sl="sudo systemctl suspend"
alias sp="sudo systemctl poweroff"
alias sr="sudo systemctl reboot"

# TMUX
alias tn="exec tmux new -A"
alias tk="tmux kill-session -a"
alias tl="tmux ls"
alias tm="iwltm --mark"
alias tt="exec tmux -L tty new -A"
ts() { num=0; [ -n "$1" ] && num="$1"; tmux switch -t "$num"; }

# TREE
alias t="tree"
alias td="tree -d"
alias tree="tree -aCI '__pycache__|.git|*.aux|*.fdb_latexmk|*.fls|*.log|*.nav|*.snm|*.gz|*.toc' --dirsfirst --noreport"

# VIM
vpa() {
    [ $# = 0 ] && url="$(xsel -b | head -n1)" || url="$1"
    name=$(echo "$url" | sed s/.git$// | sed s/.n*vim$// | sed 's/.*\///' | sed s/^n*vim-//)
    git submodule add --force --name "$name" "$url" "nvim/pack/plugins/opt/$name"
}
vpd() {
    [ $# = 0 ] && echo No submodule provided. && return
    git rm -f "nvim/pack/plugins/opt/$1"
    rm -fr ".git/modules/$1"
}

# WALLPAPERS
alias jwl="cd \$DATA/pictures/wallpapers"
alias wd="wal -d"
alias wn="cd \$DATA/pictures/wallpapers && wal"

# SHELL
case $0 in
    *bash) . "$CONFIG/shell/.bashrc" ;;
esac
