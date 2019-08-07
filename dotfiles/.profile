export EDITOR=nvim
export VISUAL=nvim

export BROWSER=firefox
export MANPAGER="nvim -c 'set ft=man' -"
export TERMINAL=st

export FZF_DEFAULT_OPTS="--ansi --cycle -m --reverse --tabstop=4 --color=bg+:-1,fg+:-1,border:#000000"
export FZF_DEFAULT_COMMAND="find . -type f ! -path '*/\.git/*' ! -path '*/tex/*' ! -iname 'tags' | sed 's/^.\///'"

[ "$(tty)" = "/dev/tty1" ] && [ "$(whoami)" != "root" ] && startx
