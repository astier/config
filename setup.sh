#!/usr/bin/env sh

[ ! -d ~/.config ] && mkdir ~/.config

install() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" &&
        echo Installed: "$TARGET"
}

cd dotfiles || exit

install .condarc ~
install .profile ~
install .pylintrc ~
install .tmux.conf ~
install bash/.bash_profile ~
install bash/.bashrc ~

install aliases ~/.config
install bash/inputrc ~/.config
install git ~/.config
install gtk-3.0 ~/.config
install herbstluftwm ~/.config
install nvim ~/.config
install pacman ~/.config
install sx ~/.config
install sxhkd ~/.config
install xkb ~/.config
install xkb/xkb.desktop ~/.config/autostart
install zathura ~/.config/

install pacman/pacman.conf /etc
install mkinitcpio.conf /etc

[ ! -d /etc/systemd/system/getty@tty1.service.d ] && sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo ln -f ~/projects/dotfiles/dotfiles/systemd/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d &&
    echo Installed: getty@tty1.service.d

sudo ln -f ~/projects/dotfiles/dotfiles/systemd/journald.conf /etc/systemd &&
    echo Installed: journald

sudo ln -f ~/projects/dotfiles/dotfiles/systemd/logind.conf /etc/systemd &&
    echo Installed: logind

sudo ln -f ~/projects/dotfiles/dotfiles/systemd/network/* /etc/systemd/network &&
    echo Installed: networkd

sudo ln -f ~/projects/dotfiles/dotfiles/iptables.rules /etc/iptables/iptables.rules
    echo Installed: iptables
