This document was last updated on 2020-08-11

# riscv-toolchain-install
Notes on how to install gnu-mcu-eclipse for risc-v development, specifically on the Logan Nano board (GD32VF103).

These are the notes I've made after trying to follow the instructions at https://gnu-mcu-eclipse.github.io/

In the proceeding steps I will present terminal commands that include `if` statements. This is to check if the relevent programs are already installed or if the relevent files/directories already exist. If you don't know what you're doing, just copy the whole text and paste it into the terminal. If you do know what you're doing you can just copy the individual commands, but you already knew that.

# Optional preparation
I am doing this using VirtualBox running on a linux host. I recomment doing the same for your initial setup. Trust me, you'll want to take snapshots when things go right and revert back to them when things go wrong. The overal experience of getting the toolchain setup is, to be polite, challenging.

## Install VirtualBox (optional)
There is no special instructions here.

## Install Ubuntu 20.04 (optional)
Maybe another version or distro would work, but this is what I'm using here.

## Install Virtual guest additions (optional)
We'll probably want the Guest Additions in order to copy and paste between the host operating system and the guest operating system. This is not necessary, but it can make things convenient.

Fire up a terminal in the guest operating system and execute the following command.
```
sudo apt-get install -y gcc make perl
```

In the VirtualBox window of your guest operating system go to Devices - Insert Guest Additions CD Image. A window should pop up and ask you if you would like to run "VBox\_GAs". Click "Run".


# Install git
You will need `git` to install several pieces of software.

In a terminal execute the following command.
```
sudo apt-get install -y git
```

Make a directory to put aur github repositories
```
if [[ -d ~/github ]]; then
    	echo "~/github already exists."
else
    	mkdir ~/github
fi
```

# download and link dotfiles
```
if [[ -d ~/github/dotfiles ]]; then
	echo "dotfiles already exists."
else
	cd ~/github
	git clone https://github.com/charlespax/dotfiles
	bash ~/github/dotfiles/link.sh
fi
```

# install  node.js
```
if command -v nodejs; then
	echo "node.js is already installed."
else
	sudo apt-get install -y nodejs
fi
```


# install npm
```
if command -v npm; then
	echo "npm is already installed."
else
	sudo apt-get install -y npm
fi
```


# install xpm
```
if command -v xpm; then
	echo "xpm is already installed."
else
	sudo npm install --global xpm@latest
fi
```


# install xpack-dev-tools
```
if command -v ~/opt/xPacks/\@xpack-dev-tools/riscv-none-embed-gcc/8.3.0-1.2.1/.content/bin/riscv-none-embed-gcc; then
	echo "riscv-non-embed-gcc is already installed."
else
	xpm install --global @xpack-dev-tools/riscv-none-embed-gcc@latest
fi
```

# install Segger J-Link support
The JLink software depends on the `ncurses` library. Install it by executing the following command.
```
if command -v ncurses; then
        echo "jlink is already installed."
else
	sudo apt-get install ncurses
fi

Go to https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb, accept the agreement by ckecking the box, and click "Download."

Save the file to your Downloads direction `~/Downloads`. Execute the following command.
```
sudo dpkg -i ~/Downloads/JLink_Linux_V682c_x86_64.deb
```
