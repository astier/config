export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export MANPAGER="nvim -c 'set ft=man' -"
export DOTFILES=~/Projects/dotfiles/dotfiles

[ -f ~/.bashrc ] && . ~/.bashrc
[[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]] && startx
