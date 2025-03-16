#!/usr/bin/env sh

copy() { sudo cp -fr "$1" "$2" && echo Installed: "$1"; }

link() {
    TARGET=$1 DESTINATION=$2
    [ -d "$2" ] && DESTINATION=$2/$(basename "$TARGET")
    rm -fr "$DESTINATION"
    ln -rs "$TARGET" "$DESTINATION" && echo Installed: "$TARGET"
}

link_sudo() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" && echo Installed: "$TARGET"
}

mkdir -p "$XDG_CONFIG_HOME"

link git "$XDG_CONFIG_HOME"
link gtk-2.0 "$XDG_CONFIG_HOME"
link gtk-3.0 "$XDG_CONFIG_HOME"
link gtk-4.0 "$XDG_CONFIG_HOME"
link ideavim "$XDG_CONFIG_HOME"
link latexmk "$XDG_CONFIG_HOME"
link markdownlint "$XDG_CONFIG_HOME"
link mimeapps.list ~/.config/
link nvim "$XDG_CONFIG_HOME"
link pylintrc "$XDG_CONFIG_HOME"
link pythonrc.py "$XDG_CONFIG_HOME"
link ripgreprc "$XDG_CONFIG_HOME"
link shell/.profile ~
link shell/.profile ~/.bashrc
link shell/inputrc "$XDG_CONFIG_HOME"
link shellcheckrc "$XDG_CONFIG_HOME"
link sx "$XDG_CONFIG_HOME"
link sxhkd "$XDG_CONFIG_HOME"
link templates "$XDG_CONFIG_HOME"
link tmux "$XDG_CONFIG_HOME"
link Xresources "$XDG_CONFIG_HOME"
link zathura "$XDG_CONFIG_HOME"

DIR="$XDG_CONFIG_HOME"/mpv
mkdir -p "$DIR"
link mpv.conf "$DIR"

DIR="$HOME/.mozilla/firefox"
PROFILE=$(grep "Default=" "$DIR/profiles.ini" | head -1 | cut -d= -f2 | cut -d. -f1)
link mozilla/chrome "$DIR/$PROFILE.default-release"
link mozilla/user.js "$DIR/$PROFILE.default-release"

DIR="$XDG_CONFIG_HOME"/autostart
mkdir -p "$DIR"
link autostart/autostart.desktop "$DIR"
link autostart/autostart.sh "$DIR"

DIR="$XDG_CONFIG_HOME"/xswm
mkdir -p "$DIR"
link autostart/autostart.sh "$DIR"

if groups "$USER" | grep -q wheel; then

    DIR=/etc/iwd
    [ ! -d "$DIR" ] && sudo mkdir "$DIR"
    copy iwd.conf "$DIR/main.conf"

    copy 00-polkit.rules /etc/polkit-1/rules.d/
    copy systemd/journald.conf.d /etc/systemd
    copy systemd/logind.conf.d /etc/systemd
    copy systemd/network/20-wired.network /etc/systemd/network
    copy systemd/network/25-wireless.network /etc/systemd/network
    copy systemd/resolved.conf.d /etc/systemd
    link_sudo iptables.rules /etc/iptables
    link_sudo locale.conf /etc
    link_sudo vconsole.conf /etc
    link_sudo xkb/symbols/custom /usr/share/X11/xkb/symbols
    link_sudo xorg.conf /etc/X11

    DIR=/usr/local/share/kbd/keymaps
    [ ! -d "$DIR" ] && sudo mkdir -p "$DIR"
    link_sudo tty.map "$DIR"
    copy systemd/system/ttyrc.service /etc/systemd/system

    DIR=/etc/xdg/reflector
    [ -d "$DIR" ] && copy reflector.conf /etc/xdg/reflector/

    # TODO: use envsubst instead of sed
    copy systemd/system/getty@.service.d /etc/systemd/system
    sudo sed -i "s|<user>|$USER|g" /etc/systemd/system/getty@.service.d/override.conf

fi
