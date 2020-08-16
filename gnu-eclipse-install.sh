#!/bin/bash

# install vim
if command -v vim; then
	echo "vim already installed."
else
	sudo apt-get install -y vim
fi

# install git
if command -v git; then
	echo "git already installed."
else
	sudo apt-get install -y git
fi

# install dependencies for virtualbox guest additions
sudo apt-get install gcc make perl

# make github directory
if [[ -d ~/github ]]; then
    	echo "~/github already exists."
else
    	mkdir ~/github
fi

# download and link dotfiles
if [[ -d ~/github/dotfiles ]]; then
	echo "dotfiles already exists."
else
	cd ~/github
	git clone https://github.com/charlespax/dotfiles
	~/github/dotfiles/link.sh
fi

# install  node.js
if command -v nodejs; then
	echo "node.js is already installed."
else
	sudo apt-get install -y nodejs
fi

# install npm
if command -v npm; then
	echo "npm is already installed."
else
	sudo apt-get install -y npm
fi

# install xpm
if command -v xpm; then
	echo "xpm is already installed."
else
	sudo npm install --global xpm@latest
fi

# install xpack-dev-tools
if command -v riscv-none-embed-gcc; then
	echo "riscv-non-embed-gcc is already installed."
else
	xpm install --global @xpack-dev-tools/riscv-none-embed-gcc@latest
fi
