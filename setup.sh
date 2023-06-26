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

link .vintrc.yaml "$XDG_CONFIG_HOME"
link .Xresources "$XDG_CONFIG_HOME"
link alacritty.yml "$XDG_CONFIG_HOME"
link dunst "$XDG_CONFIG_HOME"
link git "$XDG_CONFIG_HOME"
link gtk-2.0 "$XDG_CONFIG_HOME"
link gtk-3.0 "$XDG_CONFIG_HOME"
link gtk-4.0 "$XDG_CONFIG_HOME"
link herbstluftwm "$XDG_CONFIG_HOME"
link ideavim "$XDG_CONFIG_HOME"
link markdownlint "$XDG_CONFIG_HOME"
link mimeapps.list ~/.config/
link mpv "$XDG_CONFIG_HOME"
link nvim "$XDG_CONFIG_HOME"
link pacman "$XDG_CONFIG_HOME"
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
link tint2 "$XDG_CONFIG_HOME"
link tmux "$XDG_CONFIG_HOME"
link xkeymap "$XDG_CONFIG_HOME"
link zathura "$XDG_CONFIG_HOME"

DIR="$HOME/.mozilla/firefox"
PROFILE=$(grep "Default=" "$DIR/profiles.ini" | head -1 | cut -d= -f2 | cut -d. -f1)
link chrome "$DIR/$PROFILE.default-release"

DIR="$XDG_CONFIG_HOME"/autostart
mkdir -p "$DIR"
link autostart/autostart.desktop "$DIR"
link autostart/autostart.sh "$DIR"

DIR=$XDG_CONFIG_HOME/Code/User
if [ -d "$DIR" ]; then
    link code/code.vim "$DIR"
    link code/keybindings.json "$DIR"
    link code/settings.json "$DIR"
fi

DIR=$XDG_CONFIG_HOME/Code\ -\ OSS/User
if [ -d "$DIR" ]; then
    link code/code.vim "$DIR"
    link code/keybindings.json "$DIR"
    link code/settings.json "$DIR"
fi

if groups "$USER" | grep -q wheel; then

    DIR=/etc/iwd
    [ ! -d "$DIR" ] && sudo mkdir "$DIR"
    copy iwd.conf "$DIR/main.conf"

    copy 00-polkit.rules /etc/polkit-1/rules.d/
    copy pacman/pacman.conf /etc
    copy systemd/journald.conf.d /etc/systemd
    copy systemd/logind.conf.d /etc/systemd
    copy systemd/resolved.conf.d /etc/systemd
    link_sudo iptables.rules /etc/iptables
    link_sudo locale.conf /etc
    link_sudo thinkfan.conf /etc
    link_sudo vconsole.conf /etc
    link_sudo xorg.conf /etc/X11

    DIR=/usr/local/share/kbd/keymaps
    [ ! -d "$DIR" ] && sudo mkdir -p "$DIR"
    link_sudo key.map "$DIR"
    copy systemd/system/tty-conf.service /etc/systemd/system

    sudo rm /etc/NetworkManager/NetworkManager.conf

    [ ! -f /etc/default/grub ] && copy grub /etc/default

    # TODO: use envsubst instead of sed
    copy systemd/system/getty@.service.d /etc/systemd/system
    sudo sed -i "s|<user>|$USER|g" /etc/systemd/system/getty@.service.d/override.conf

    sudo rm /etc/udev/rules.d/00-udev.rules

fi
