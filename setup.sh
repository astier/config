#!/usr/bin/env sh

[ ! -d ~/.config ] && mkdir ~/.config

install() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" &&
        echo Installed: "$TARGET"
}

cd dotfiles || exit

install .aliases ~
install .condarc ~
install .profile ~
install .tmux.conf ~
install bash/.bash_profile ~
install bash/.bashrc ~
install bash/.inputrc ~

install feh ~/.config/
install git ~/.config
install gtk-3.0 ~/.config
install herbstluftwm ~/.config
install nvim ~/.config
install pacman ~/.config
install rofi ~/.config
install sx ~/.config
install sxhkd ~/.config
install code/settings.json ~/.config/Code/User/
install xkb ~/.config
install xkb/xkb.desktop ~/.config/autostart

install pacman/pacman.conf /etc
install mkinitcpio.conf /etc

sudo iptables-restore < iptables.rules &&
    echo Installed: iptables

[ ! -d /etc/systemd/system/getty@tty1.service.d ] && sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo ln -f ~/projects/dotfiles/dotfiles/systemd/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d &&
    echo Installed: getty@tty1.service.d

sudo ln -f ~/projects/dotfiles/dotfiles/systemd/journald.conf /etc/systemd &&
    echo Installed: journald

sudo ln -f ~/projects/dotfiles/dotfiles/systemd/logind.conf /etc/systemd &&
    echo Installed: logind

sudo ln -f ~/projects/dotfiles/dotfiles/systemd/network/* /etc/systemd/network &&
    echo Installed: networkd
