This document was last updated on 2020-08-11

# riscv-toolchain-install
Notes on how to install gnu-mcu-eclipse for risc-v development, specifically on the Logan Nano board (GD32VF103).

These are the notes I've made after trying to follow the instructions at https://gnu-mcu-eclipse.github.io/

In the proceeding steps I will present terminal commands that include `if` statements. This is to check if the relevent programs are already installed or if the relevent files/directories already exist. If you don't know what you're doing, just copy the whole text and paste it into the terminal. If you do know what you're doing you can just copy the individual commands, but you already knew that.

# Optional preparation
I am doing this using VirtualBox running on a linux host. I recomment doing the same for your initial setup. Trust me, you'll want to take snapshots when things go right and revert back to them when things go wrong. The overal experience of getting the toolchain setup is, to be polite, challenging.

## Install VirtualBox (optional)
There is no special instructions here.

## Install Linux Mint 20 (optional)
Maybe another version or distro would work, but this is what I'm using here. When the system is installed, do a system update using the following command.
```
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
```

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
The instructions that I've read all utilize the Segger J-Link debugger probe. For hobbiests, just go buy the education version (https://www.segger.com/products/debug-probes/j-link/models/j-link-edu-mini/). Get that working before trying to use another probe.

Note: Segger's Longan Nano wiki page https://wiki.segger.com/SiPeed_Longan_Nano
Note: J-Link hardware revisions 10 and above support risc-v, lower revisions do not. For a feature comparison overview see https://wiki.segger.com/Software_and_Hardware_Features_Overview

The JLink software depends on the `ncurses` library. Install it by executing the following command.
```
if command -v ncurses; then
        echo "ncurses is already installed."
else
	sudo apt-get install libncurses5
fi
```

Go to https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb, accept the agreement by ckecking the box, and click "Download."

Save the file to your Downloads directory `~/Downloads`. Execute the following command.
```
if command -v JLinkGDBServer; then
	echo "jlink is already installed."
else
	sudo dpkg -i ~/Downloads/JLink_Linux_V682c_x86_64.deb
fi
```

# install OpenOCD
```
if command -v ~/opt/xPacks/@xpack-dev-tools/openocd/0.10.0-14.3/.content/bin/openocd; then
	echo "openocd is already installed."
else
        xpm install --global @xpack-dev-tools/openocd@latest
fi
```

# install QEMU (DON'T DO)
This iseems to be for ARM, so maybe don't install it.
```
if comman d -v ~/opt/xPacks/@xpack-dev-tools/qemu-arm/2.8.0-9.1; then
        echo "qemu is already installed."
else
        xpm install --global @xpack-dev-tools/qemu-arm@latest
fi
```

# install java
This should already be installed.

# install Eclipse and CDT

```
ECLIPSE_FILE=https://github-production-release-asset-2e65be.s3.amazonaws.com/92777692/aca90500-4118-11ea-9a74-7556a740493a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200812%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200812T205855Z&X-Amz-Expires=300&X-Amz-Signature=d8eb15adb5fa6adcd8dbc41db6868670570bbe3519a028fe5c6687b73cdffd03&X-Amz-SignedHeaders=host&actor_id=281642&repo_id=92777692&response-content-disposition=attachment%3B%20filename%3D20200127-1311-gnumcueclipse-4.7.2-2019-12-R-linux.gtk.x86_64.tar.gz&response-content-type=application%2Foctet-stream

cd ~/Downloads

if command -v wget; then
        wget -c $ECLIPSE_FILE
fi
```

Extract eclipse
```
tar -xvzf ~/Downloads/*gnumcueclipse*.tar.gz -C ~/
```
Make a menu shortcut
```
ECLIPSE=/eclipse/eclipse
FULL_PATH=$HOME$ECLIPSE
echo \
[Desktop Entry] \
Name=Eclipse \
Exec=$FULL_PATH \
Terminal=false \
Type=Application \
Icon=/full/path/to/the/icon-file \
>> ~/.local/share/applications/eclipse.desktop
```
