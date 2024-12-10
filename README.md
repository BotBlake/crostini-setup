# Crostini-Setup

A setup script for configuring the Crostini Linux VM on Chromebooks. This script automates essential setup tasks, installs useful tools, and prepares your environment for development.

## Features
- Adds `i386` architecture support and non-free Debian repositories.
- Installs essential tools (`curl`, `wget`, `git`, `vim`, etc.).
- Configures libraries for i386 compatibility.
- Sets up Python development environment.
- Installs Jellyfin and VSCode optionally.
- Performs system updates and cleanups.

## Prerequisites
- Chromebook with Crostini enabled.
- Root privileges to execute the script (use `sudo`).

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/crostini-setup.git
   cd crostini-setup
    ```
   
2. Make the script executable:
    ```bash
    chmod +x crostini-setup.sh
    ```
3. Run the script with root privileges:
    ```bash
    sudo ./install.sh
    ```
  Follow the prompts for optional installations (e.g., Jellyfin, VSCode).

## Log File
The script logs all output to /var/log/crostini_setup.log for debugging purposes.
