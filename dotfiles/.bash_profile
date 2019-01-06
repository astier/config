export EDITOR=vi
export PATH=$PATH:~/miniconda3/bin:~/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
    startx
fi
