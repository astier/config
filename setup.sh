#!/usr/bin/env sh

install() {
	TARGET=$1 DESTINATION=$2$(basename "$TARGET")
	sudo rm -fr "$DESTINATION"
	sudo ln -rs dotfiles/"$TARGET" "$DESTINATION" &&
		echo Installed: "$TARGET"
}

install .condarc ~/
install .inputrc ~/
install .tmux.conf ~/
install .xinitrc ~/
install bash/.bash_profile ~/
install bash/.bashrc ~/

install dunst ~/.config/
install feh ~/.config/
install git ~/.config/
install gtk-3.0 ~/.config/
install nvim ~/.config/
install zathura ~/.config/

install pacman/hooks/ /etc/pacman.d/
install pacman/pacman.conf /etc/
install st.desktop /usr/share/applications/

[ ! -d /etc/systemd/system/getty@tty1.service.d ] && sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo ln -f ~/Projects/dotfiles/dotfiles/systemd/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d/ &&
	echo Installed: getty@tty1.service.d

sudo ln -f ~/Projects/dotfiles/dotfiles/systemd/journald.conf /etc/systemd/ &&
	echo Installed: journald

sudo ln -f ~/Projects/dotfiles/dotfiles/systemd/logind.conf /etc/systemd/ &&
	echo Installed: logind

sudo ln -f ~/Projects/dotfiles/dotfiles/systemd/network/* /etc/systemd/network/ &&
	echo Installed: networkd
