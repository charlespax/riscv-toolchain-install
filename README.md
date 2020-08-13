This document was last updated on 2020-08-11

# riscv-toolchain-install
This document is a series of notes on how I have installed and configured gnu-mcu-eclipse for risc-v development, specifically on the Logan Nano board (GD32VF103). The software is installed on a system running Linux Mint 20 64-bit.

The instructions are based on the information located at https://gnu-mcu-eclipse.github.io.

In the proceeding steps I will present terminal commands that include `if` statements. This is to check if the relevent programs are already installed or if the relevent files/directories already exist. If you don't know what you're doing, just copy the whole text and paste it into the terminal. If you do know what you're doing you can just copy the individual commands, but you already knew that.

# Optional preparation (optional)
For your first time I recomment installing all of this in a virtual machine. Trust me, you'll want to take snapshots when things go right and revert back to them when things go wrong. There will be a few extra steps to ensure your hardware can talk to the virtual machine, but it is worth the effort.

## Install VirtualBox
Install the latest VirtualBox on your system. Also install the extensions pack.

## Install Linux Mint 20
Download Linux Mint 20 from https://linuxmint.com/edition.php?id=281

The Linux Mint 20 installer will require a little over 12 GB of storage, so make a VM around 20 GB or greater. Maybe another version or distro would work, but this is what I'm using here.

After the system is installed, do a system update using the following commands.
```
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
```

## Install Virtual guest additions
Installing the Virtual Guest Additions will allow you to copy and paste between the guest and host operating systems. I think it's also required for connecting physical USB devices to the guest operating system.

Fire up a terminal in the guest operating system and execute the following command.
```
sudo apt-get install -y gcc make perl
```

In the VirtualBox window of your guest operating system go to Devices - Insert Guest Additions CD Image. A window should pop up and ask you if you would like to run "VBox\_GAs". Click "Run".

Enable copy-and-paste between the guest and host operating systems by selecting Devices, Shared Clipboard, Bidirectional.

Restart the system with the following command or by using the menu in the upper right corner of your virtual machine desktop.
```
sudo reboot
```

# Install git
You will need `git` to install several pieces of software.

In a terminal execute the following command.
```
sudo apt-get install -y git
```

Make a directory to put our github repositories
```
if [[ -d ~/github ]]; then
    	echo "~/github already exists."
else
    	mkdir ~/github
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
	sudo apt-get install -y libncurses5
fi
```

Go to the Segger web site by executing the following command.
```
firefox https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
```

 Accept the agreement by ckecking the box, and click "Download Software." Save the file to your Downloads directory `~/Downloads`. Close the Firefox window.

Execute the following command.
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

# install Eclipse and CDT

```
ECLIPSE_FILE=http://eclipse.mirror.rafal.ca/embed-cdt/packages/2020-06/eclipse-embedcdt-2020-06-R-linux.gtk.x86_64.tar.gz

cd ~/Downloads
wget -c $ECLIPSE_FILE
```

Extract eclipse
```
tar -xvzf ~/Downloads/eclipse-embedcdt-2020-06-R-linux.gtk.x86_64.tar.gz -C ~/
```
Make a menu shortcut
```
if [[ -d ~/.local/share/applications ]]; then
	echo "shortcut dir exists."
else
	mkdir -p ~/.local/share/applications
fi

ECLIPSE=/eclipse/eclipse
ICON=/eclipse/icon.xpm
FULL_PATH=$HOME$ECLIPSE
echo " [Desktop Entry]
Encoding=UTF-8
Name=Eclipse IDE
Comment=Eclipse IDE
Exec=$FULL_PATH
Icon=$HOME$ICON
Terminal=false
Type=Application
Categories=Development;Programming
StartupNotify=false" \
>> ~/.local/share/applications/eclipse.desktop
```

If want the Eclipse IDE menu entry to appear in the menu, you have to log out and log back in. I simply haven't found a way to automate this.

# Othe Notes
This section is just a vew notes I'm taking while writing this document.

To find which preferenc files have been changed use the following command.
```
find ~  -type f -mmin -1
```

## Enable automatic save
File:
```
/home/mcu/eclipse-workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.ui.ide.prefs
```

Text:
```
PROBLEMS_FILTERS_MIGRATE=true
SAVE_ALL_BEFORE_BUILD=true
eclipse.preferences.version=1
platformState=1597324309252
quickStart=false
tipsAndTricks=true
```
