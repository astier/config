#!/usr/bin/env sh

copy() { sudo cp -fr "$1" "$2" && echo Installed: "$1"; }

link() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    rm -fr "$DESTINATION"
    ln -rs "$TARGET" "$DESTINATION" && echo Installed: "$TARGET"
}

link_sudo() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" && echo Installed: "$TARGET"
}

mkdir -p "$XDG_CONFIG_HOME"

link .bashrc ~
link .profile ~
link alacritty.yml "$XDG_CONFIG_HOME"
link dunst "$XDG_CONFIG_HOME"
link feh "$XDG_CONFIG_HOME"
link git "$XDG_CONFIG_HOME"
link gtk-2.0 "$XDG_CONFIG_HOME"
link gtk-3.0 "$XDG_CONFIG_HOME"
link gtk-4.0 "$XDG_CONFIG_HOME"
link ideavim "$XDG_CONFIG_HOME"
link inputrc "$XDG_CONFIG_HOME"
link markdownlint "$XDG_CONFIG_HOME"
link mimeapps.list ~/.config/
link nvim "$XDG_CONFIG_HOME"
link pylintrc "$XDG_CONFIG_HOME"
link pythonrc.py "$XDG_CONFIG_HOME"
link shellcheckrc "$XDG_CONFIG_HOME"
link shrc "$XDG_CONFIG_HOME"
link skippy-xd "$XDG_CONFIG_HOME"
link templates "$XDG_CONFIG_HOME"
link tig "$XDG_CONFIG_HOME"
link tmux "$XDG_CONFIG_HOME"
link xkb "$XDG_CONFIG_HOME"
link zathura "$XDG_CONFIG_HOME"

DIR="$HOME/.mozilla/firefox"
PROFILE=$(grep "Default=" "$DIR/profiles.ini" | head -1 | cut -d= -f2 | cut -d. -f1)
link chrome "$DIR/$PROFILE.default-release"

link plank "$XDG_CONFIG_HOME"
dconf load /net/launchpad/plank/docks/ < plank/config.ini

DIR="$XDG_CONFIG_HOME"/autostart
mkdir -p "$DIR"
link autostart/xbanish.desktop "$DIR"
link autostart/xkbcomp.desktop "$DIR"

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

    copy pacman/pacman.conf /etc
    copy systemd/journald.conf.d /etc/systemd
    copy systemd/logind.conf.d /etc/systemd
    copy systemd/resolved.conf.d /etc/systemd
    copy systemd/system.conf.d /etc/systemd
    link herbstluftwm "$XDG_CONFIG_HOME"
    link newsboat "$XDG_CONFIG_HOME"
    link pacman "$XDG_CONFIG_HOME"
    link sx "$XDG_CONFIG_HOME"
    link sxhkd "$XDG_CONFIG_HOME"
    link tint2 "$XDG_CONFIG_HOME"
    link_sudo iptables.rules /etc/iptables
    link_sudo thinkfan.conf /etc
    link_sudo vconsole.conf /etc
    link_sudo xorg.conf /etc/X11

    DIR=/usr/local/share/kbd/keymaps
    [ ! -d "$DIR" ] && sudo mkdir -p "$DIR"
    link_sudo key.map "$DIR"
    copy systemd/system/tty-conf.service /etc/systemd/system

    DIR=/etc/NetworkManager
    [ ! -d "$DIR" ] && sudo mkdir "$DIR"
    link_sudo NetworkManager.conf "$DIR"

    [ ! -f /etc/default/grub ] && copy grub /etc/default

    # TODO: use envsubst instead of sed
    copy systemd/system/getty@.service.d /etc/systemd/system
    sudo sed -i "s|<user>|$USER|g" /etc/systemd/system/getty@.service.d/override.conf

    # copy 10-udev.rules /etc/udev/rules.d/
    # sudo sed -i "s|<user>|$USER|g" /etc/udev/rules.d/10-udev.rules

fi
