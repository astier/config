#!/usr/bin/env sh

link() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" &&
        echo Installed: "$TARGET"
}

mkdir -p ~/.config
cd dotfiles || exit

link .bashrc ~
link .profile ~
link aliases ~/.config
link git ~/.config
link gtk-3.0 ~/.config
link inputrc ~/.config
link iptables.rules /etc/iptables
link mimeapps.list ~/.config/
link nvim ~/.config
link pacman ~/.config
link pacman/pacman.conf /etc
link pylintrc ~/.config
link pythonrc.py ~/.config
link shellcheckrc ~/.config
link sx ~/.config
link sxhkd ~/.config
link templates ~/.config
link tmux.conf ~/.config
link tty-cursor.conf /etc/tmpfiles.d
link xkb ~/.config

copy() { sudo cp -fr "$1" "$2" && echo Installed: "$1"; }

copy iwd.conf /etc/iwd/main.conf
copy systemd/journald.conf /etc/systemd
copy systemd/logind.conf /etc/systemd
copy systemd/resolved.conf /etc/systemd
copy systemd/system.conf /etc/systemd
copy systemd/system/getty@tty1.service.d /etc/systemd/system
copy systemd/system/getty@tty2.service.d /etc/systemd/system
