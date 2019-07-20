export EDITOR=nvim
export VISUAL=nvim

export BROWSER=firefox
export MANPAGER="nvim -c 'set ft=man' -"
export _JAVA_AWT_WM_NONREPARENTING=1

export FZF_DEFAULT_OPTS="--ansi --cycle -m --reverse --tabstop=4 --color=bg+:-1,fg+:-1,border:#000000"
export FZF_DEFAULT_COMMAND="find . -type f ! -path '*/\.git/*' ! -path '*/tex/*' ! -iname 'tags' ! -iname '*\.jpg' ! -iname '*\.jpeg' ! -iname '*\.png' ! -iname '*\.pdf' ! -iname '*\.gif' ! -iname '*\.css' ! -iname '*\.html' ! -iname '*\.js' ! -iname '*\.htm' ! -iname '*\.docx' ! -iname '*\.doc' ! -iname '*\.odt' ! -iname '*\.zip' ! -iname '*\.tar.gz' | sed 's/^.\///'"

[ "$(tty)" = "/dev/tty1" ] && [ "$(whoami)" != "root" ] && startx
