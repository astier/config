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
link chrome "$HOME"/.mozilla/firefox/kvd3mum3.default-release # TODO: automatically figure out profile-name
link dunst "$XDG_CONFIG_HOME"
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

link plank "$XDG_CONFIG_HOME"
dconf load /net/launchpad/plank/docks/ < plank/config.ini

mkdir -p "$XDG_CONFIG_HOME"/autostart
link autostart/xbanish.desktop "$XDG_CONFIG_HOME"/autostart
link autostart/xkbcomp.desktop "$XDG_CONFIG_HOME"/autostart

code_dir=$XDG_CONFIG_HOME/Code/User
if [ -d "$code_dir" ]; then
    link code/code.vim "$code_dir"
    link code/keybindings.json "$code_dir"
    link code/settings.json "$code_dir"
fi

code_dir=$XDG_CONFIG_HOME/Code\ -\ OSS/User
if [ -d "$code_dir" ]; then
    link code/code.vim "$code_dir"
    link code/keybindings.json "$code_dir"
    link code/settings.json "$code_dir"
fi

if groups "$USER" | grep -q wheel; then

    iwd=/etc/iwd
    [ ! -d "$iwd" ] && sudo mkdir "$iwd"
    copy iwd.conf "$iwd"/main.conf

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
    link_sudo pacman/pacman.conf /etc
    link_sudo systemd/system/getty@tty1.service.d /etc/systemd/system
    link_sudo systemd/system/getty@tty2.service.d /etc/systemd/system
    link_sudo tty-cursor.conf /etc/tmpfiles.d
    link_sudo xorg.conf /etc/X11

    nm_dir=/etc/NetworkManager
    if [ -d "$nm_dir" ]; then
        link_sudo NetworkManager.conf "$nm_dir"
    fi

    # copy 10-udev.rules /etc/udev/rules.d/
    # sudo sed -i "s|\$HOME|$HOME|g" /etc/udev/rules.d/10-udev.rules

fi
