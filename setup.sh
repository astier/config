#!/usr/bin/env sh

copy() { sudo cp -fr "$1" "$2" && echo Installed: "$1"; }

link() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    rm -fr "$DESTINATION"
    ln -rs "$TARGET" "$DESTINATION" && echo Installed: "$TARGET"
}

mkdir -p "$XDG_CONFIG_HOME"

link .bashrc ~
link .profile ~
link aliases "$XDG_CONFIG_HOME"
link git "$XDG_CONFIG_HOME"
link gtk-2.0 "$XDG_CONFIG_HOME"
link gtk-3.0 "$XDG_CONFIG_HOME"
link inputrc "$XDG_CONFIG_HOME"
link markdownlint "$XDG_CONFIG_HOME"
link mimeapps.list ~/.config/
link nvim "$XDG_CONFIG_HOME"
link pylintrc "$XDG_CONFIG_HOME"
link pythonrc.py "$XDG_CONFIG_HOME"
link shellcheckrc "$XDG_CONFIG_HOME"
link templates "$XDG_CONFIG_HOME"
link tmux "$XDG_CONFIG_HOME"
link xkb "$XDG_CONFIG_HOME"
link zathura "$XDG_CONFIG_HOME"

code_dir="$XDG_CONFIG_HOME"/Code/User
if [ -d "$code_dir" ]; then
    link code/code.vim "$code_dir"
    link code/keybindings.json "$code_dir"
    link code/settings.json "$code_dir"
fi

code_dir="$XDG_CONFIG_HOME"/Code\ -\ OSS/User
if [ -d "$code_dir" ]; then
    link code/code.vim "$code_dir"
    link code/keybindings.json "$code_dir"
    link code/settings.json "$code_dir"
fi

if groups "$USER" | grep -q wheel; then

    copy iptables.rules /etc/iptables
    copy iwd.conf /etc/iwd/main.conf
    copy NetworkManager.conf /etc/NetworkManager
    copy pacman/pacman.conf /etc
    copy sofficerc /etc/libreoffice
    copy systemd/journald.conf /etc/systemd
    copy systemd/logind.conf /etc/systemd
    copy systemd/resolved.conf /etc/systemd
    copy systemd/system.conf /etc/systemd
    copy systemd/system/getty@tty1.service.d /etc/systemd/system
    copy systemd/system/getty@tty2.service.d /etc/systemd/system
    copy tty-cursor.conf /etc/tmpfiles.d
    copy xorg.conf /etc/X11
    link herbstluftwm "$XDG_CONFIG_HOME"
    link pacman "$XDG_CONFIG_HOME"
    link sx "$XDG_CONFIG_HOME"
    link sxhkd "$XDG_CONFIG_HOME"
    link tint2 "$XDG_CONFIG_HOME"

    # copy 10-udev.rules /etc/udev/rules.d/
    # sudo sed -i "s|\$HOME|$HOME|g" /etc/udev/rules.d/10-udev.rules

fi
