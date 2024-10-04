#!/bin/bash

set -eu -o pipefail

install () {
	if [ $(hash yay) ]; then
		yes | yay --answerdiff None --answerclean None -S $@
	else
		sudo pacman -S --noconfirm --needed $@
	fi;
}

ensure() {
	hash $1 || install $1
}

setup_common() {
	echo "Setting up common dependencies..."

	install git base-devel
}

setup_awesome() {
	echo "Setting up awesome wm..."

	install awesome xrectsel scrot
	mkdir -p "$HOME/.config/awesome"
	cp -r .config/awesome "$HOME/.config/awesome"
}

setup_yay() {
	echo "Setting up yay package manager..."

	cd /tmp
	git clone --depth=1 https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	rm -rf /tmp/yay
}

setup_neovim() {
	echo "Setting up neovim..."

	install neovim ripgrep

	packer_dest="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
	if [ ! -d "$packer_dest" ] ; then
		git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dest"
	fi

	cp -r .config/nvim "$HOME/.config/nvim"
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

setup_alacritty() {
	install alacritty
	mkdir -p "$HOME/.config/alacritty"
	cp -r .config/alacritty "$HOME/.config/alacritty"
}

setup_nvidia() {
	echo "Setting up nvidia drivers..."

	install nvidia
	# remove kms hook from mkinitcpio.conf, this ensure the correct drivers are loaded
	sed_cmd="%s/kms //"
	sudo sed -i "$sed_cmd" /etc/mkinitcpio.conf
	# regenerate initramfs
	sudo mkinitcpio -p linux
}

setup_tmux() {
	echo "Setting up tmux..."

	install tmux
}

# All the code is wrapped in a main function that gets called at the
# bottom of the file, so that a truncated partial download doesn't end
# up executing half a script.
main() {
	setup_common
	setup_yay
	setup_awesome
	setup_neovim
	setup_alacritty
	setup_tmux
}

main
