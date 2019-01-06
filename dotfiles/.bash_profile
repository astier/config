export DOTFILES=~/Projects/dotfiles/dotfiles
export EDITOR=nvim
export PATH=$PATH:~/miniconda3/bin:~/bin

powerline-daemon -q
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
    startx
fi
