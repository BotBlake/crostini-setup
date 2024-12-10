#!/bin/bash

set -ex

# A lot of Software requires i396 architecture
echo "Adding i386 architecture"
sudo dpkg --add-architecture i386

# Add sources
echo "Adding non-free sources"
sudo chmod a+rwx /etc/apt/sources.list && sudo echo 'deb http://deb.debian.org/debian/ stable main contrib non-free' > /etc/apt/sources.list

# reload apt
echp "Updating APT"
sudo apt update && sudo apt upgrade -y

# Install Packages
echo "Installing exFat"
sudo apt install exfat-fuse exfatprogs -y

#echo "Installing additional libraries"
#sudo apt install libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386 libc6-i386 -y
