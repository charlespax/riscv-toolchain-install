# riscv-toolchain-install
Notes on how to install gnu-mcu-eclipse for risc-v development, specifically on the Logan Nano board (GD32VF103).

# Optional preparation
I am doing this using VirtualBox running on a linux host. I recomment doing the same for your initial setup. Trust me, you'll want to take snapshots when things go right and revert back to them when things go wrong. The overal experience of getting the toolchain setup is, to be polite, challenging.

# Install VirtualBox
There is no special instructions here.

# Install Ubuntu 20.04
Maybe another version or distro would work, but this is what I'm using here.

# Install git
You will need `git` to install several pieces of software.

In the guest operating system terminal execute the following command.
```
sudo apt-get install -y git
```

# Install Virtual guest additions (optional)
We'll probably want the Guest Additions in order to copy and paste between the host operating system and the guest operating system. This is not necessary, but it can make things convenient.

Fire up a terminal in the guest operating system and execute the following command.
```
sudo apt-get install -y gcc make perl
```

In the VirtualBox window of your guest operating system go to Devices - Insert Guest Additions CD Image. A window should pop up and ask you if you would like to run "VBox\_GAs". Click "Run".

# Install my dotfiles (optional)
These notes are mostly for myself, so in this step I will install things I like to have on a system. You can skip this step.

