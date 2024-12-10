#!/bin/bash

set -euo pipefail

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Please use 'sudo'." >&2
  exit 1
fi

# Redirect output to a log file
LOGFILE="/var/log/crostini_setup.log"
exec > >(tee -i $LOGFILE) 2>&1

echo "Starting configuration script for Crostini VM..."

# Backing up /etc/apt/sources.list
echo "Backing up /etc/apt/sources.list..."
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Adding i386 architecture
echo "Adding i386 architecture..."
dpkg --add-architecture i386

# Adding non-free sources
echo "Adding non-free sources..."
if ! grep -q "deb http://deb.debian.org/debian/ stable main contrib non-free" /etc/apt/sources.list; then
  echo "deb http://deb.debian.org/debian/ stable main contrib non-free" >> /etc/apt/sources.list
else
  echo "Sources already present."
fi

# Updating and upgrading the system
echo "Updating APT and upgrading the system..."
apt update && apt upgrade -y

# Installing exFAT tools
echo "Installing exFAT tools..."
apt install -y exfat-fuse exfatprogs

# Installing additional essential tools
echo "Installing essential tools..."
apt install -y curl wget git build-essential vim htop

# Installing i386 libraries
echo "Installing i386 libraries..."
apt install -y libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386 libc6-i386

# Cleaning up unused packages
echo "Cleaning up unused packages..."
apt autoremove -y && apt clean

# Installing Python-dev
echo "Installing Python-Dev"
sudo apt-get install -y python3-pip python3-dev python3-venv build-essential libssl-dev libffi-dev

echo "Configuration completed!"

# Jellyfin
read -p "Do you want to install Jellyfin? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Installing Jellyfin..."
    curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
fi

# VSCode
read -p "Do you want to install VSCode? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Installing Visual Studio Code..."
    sudo apt-get install -y gnome-keyring
    curl -o code.deb -L http://go.microsoft.com/fwlink/?LinkID=760868 && sudo apt install -y ./code.deb
    rm ./code.deb
fi

# Discord
read -p "Do you want to install Discord? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Installing Discord..."
    curl -L -o discord.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
    sudo apt install -y ./discord.deb
    rm ./discord.deb
fi

# Media Player Tooling
read -p "Do you want to extend Media playback support? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Installing VLC media player..."
    apt install -y vlc
    echo "Installing multimedia codecs..."
    apt install -y ffmpeg libavcodec-extra
fi

# MakeMKV
read -p "Do you want to install makemkv? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Installing VLC media player..."
    apt install -y vlc
    echo "Installing multimedia codecs..."
    apt install -y ffmpeg libavcodec-extra
fi
