This document was last updated on 2020-08-16

# riscv-toolchain-install
This document gives instructions on how to get code running on the Longan Nano with debugging support. At the end you will be able to compile and load code onto your device and be able to connect to your device for debugging (i.e. read registers, change variables, set/use breakpoints, ets.).

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

# Install the development environment
## Update your system
This all assumes you have Linux Mint 20 installed.

Update your system with the following commands
```
sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
```

## Microsoft VSCode 
VSCode is a wonderful open-source integrated development environment (IDE) from Microsoft. First we install this and then we will install extensions to allow development with the Longan Nano board form Sipeed.

*TODO: Add link to the download page in case the download link no longer works.*

Download VS Code"
```
wget -c https://az764295.vo.msecnd.net/stable/db40434f562994116e5b21c24015a2e40b2504e6/code_1.48.0-1597304990_amd64.deb -P ~/Downloads
```

Install VS Code
```
sudo dpkg -i code*.deb
```

Verify VS Code is working
```
code --version
```

## Install PlatformiO
The command below may not be necessary, verify.
```
sudo apt-get install python3-distutils -y
```

Install PlatformIO extensions:
```
code --install-extension platformio.platformio-ide
```

Add the platformio binaries to your PATH
```
echo export PATH=$PATH:$HOME/.platformio/penv/bin:$PATH >> ~/.bashrc
```

Install some dependencies, which are needed by oenocd
```
sudo apt-get install libusb-0.1-4 -y libftdi1 libhidapi-hidraw0 libncursesw5
```

Install GD32V platform definition
```
platformio platform install gd32v
```

When uploading to the Nano, platformio will install `tool-gd32vflash` and `tool-dfuutil`. Figure out how to install these before running the application.

Add the Longan Nano UDEV rule
```
echo "# Longan Nano, make the device world writeable.
ATTRS{idVendor}==\"28e9\", ATTRS{idProduct}==\"0189\", MODE=\"0666\" " | \
sudo tee --append /etc/udev/rules.d/99-platformio-udev.rules
```

Add the Longan Nano JLink rule
```
echo "# Segger JLink, make the device world writeable.
ATTRS{idVendor}==\"1366\", ATTRS{idProduct}==\"0101\", MODE=\"0666\" " | \
sudo tee --append /etc/udev/rules.d/99-platformio-udev.rules

```
Reload `udev` rules
```
sudo udevadm control --reload
```

Add openocd to your path. OpenOCD will be installed later by PlatformIO when we
run it, but we can add it to the `PATH` now.
```
echo export PATH=$PATH:$HOME/.platformio/packages/tool-openocd-gd32v/bin >> ~/.bashrc
```

