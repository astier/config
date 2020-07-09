#!/usr/bin/env sh

copy() { sudo cp -fr "$1" "$2" && echo Installed: "$1"; }

link() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    rm -fr "$DESTINATION"
    ln -rs "$TARGET" "$DESTINATION" && echo Installed: "$TARGET"
}

mkdir -p ~/.config
cd dotfiles || return

link .bashrc ~
link .profile ~
link aliases ~/.config
link git ~/.config
link inputrc ~/.config
link nvim ~/.config
link pythonrc.py ~/.config
link tmux ~/.config
link xkb ~/.config

if groups "$USER" | grep -q wheel; then

    copy iptables.rules /etc/iptables
    copy iwd.conf /etc/iwd/main.conf
    copy pacman/pacman.conf /etc
    copy systemd/journald.conf /etc/systemd
    copy systemd/logind.conf /etc/systemd
    copy systemd/resolved.conf /etc/systemd
    copy systemd/system.conf /etc/systemd
    copy systemd/system/getty@tty1.service.d /etc/systemd/system
    copy systemd/system/getty@tty2.service.d /etc/systemd/system
    copy tty-cursor.conf /etc/tmpfiles.d
    link gtk-2.0 ~/.config
    link gtk-3.0 ~/.config
    link herbstluftwm ~/.config
    link newsboat ~/.config/
    link pacman ~/.config
    link pylintrc ~/.config
    link shellcheckrc ~/.config
    link sx ~/.config
    link sxhkd ~/.config
    link templates ~/.config
    link tint2 ~/.config
    link zathura ~/.config

fi
