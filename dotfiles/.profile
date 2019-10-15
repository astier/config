export BROWSER=firefox
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
export TERMINAL=st
export VISUAL=nvim

export FZF_DEFAULT_COMMAND="find . -type f ! -path '*/\.git/*' ! -path '*/tex/*' ! -path '*/build/*' ! -iname 'tags' | sed 's/^.\///'"
export FZF_DEFAULT_OPTS="--ansi --cycle -m --reverse --tabstop=4 --color=bg+:-1,fg+:-1,border:#000000"

export INPUTRC="$HOME/.config/inputrc"
export PYLINTRC="$HOME/.config/pylintrc"

[ "$(tty)" = "/dev/tty1" ] && [ "$(whoami)" != "root" ] && sx
