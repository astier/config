export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export MANPAGER="nvim -c 'set ft=man' -"
export DOTFILES=~/Projects/dotfiles/dotfiles
export _JAVA_AWT_WM_NONREPARENTING=1

[ -f ~/.bashrc ] && . ~/.bashrc
[[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]] && startx
