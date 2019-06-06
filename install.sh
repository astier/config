#!/usr/bin/env sh

install() {
	TARGET=$1 DESTINATION=$2$(basename "$TARGET")
	sudo rm -fr "$DESTINATION"
	sudo ln -rs dotfiles/"$TARGET" "$DESTINATION" &&
		echo Installed: "$TARGET"
}

install .inputrc ~/
install .tmux.conf ~/
install bash/.bash_profile ~/
install bash/.bashrc ~/
install xorg/.xinitrc ~/
install feh ~/.config/
install git ~/.config/
install gtk-3.0 ~/.config/
install mimeapps.list ~/.config/
install newsboat ~/.config/
install nvim ~/.config/
install nvim/onedark.vim ~/.local/share/nvim/plugins/vim-airline-themes/autoload/airline/themes/
install vscode/settings.json ~/.config/Code/User/
install vscode/settings.json "$HOME/.config/Code - OSS/User/"
install zathura ~/.config/
install pacman/pacman.conf /etc/
install pacman/hooks/ /etc/pacman.d/

sudo rm /etc/systemd/journald.conf
sudo ln ~/Projects/dotfiles/dotfiles/systemd/journald.conf /etc/systemd/journald.conf &&
	echo Installed: journald
sudo rm /etc/systemd/logind.conf
sudo ln ~/Projects/dotfiles/dotfiles/systemd/logind.conf /etc/systemd/logind.conf &&
	echo Installed: logind
sudo rm /etc/systemd/network/*
sudo ln ~/Projects/dotfiles/dotfiles/systemd/network/* /etc/systemd/network/ &&
	echo Installed: networkd
