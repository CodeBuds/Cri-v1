#!/bin/bash
#Directories for all files
AUTHORS="David Smerkous and Eli Smith"
MODIFIERS="NONE"
URL="https://raw.github.com/CodeBuds/Cri/master"
CRIBIN=/usr/bin

cd 
cd Downloads
echo 'Welcome to the Cri installer, this will install Cri in 5 seconds, hit ctrl+z to stop if unwanted'
sleep 5

user=$(whoami)
architecture=$(uname -m)

echo "You are running as $USER, and on a $ARCHITECTURE computer"
echo ""
echo "Developed by $AUTHORS"
echo ""

sleep 2

read -p "Is Cri already on your system? [y] or [n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
echo "Installing pre files"
sudo wget "https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton" --no-check-certificate -q
echo "Done"
echo "..."

sleep 1
    echo "Installing"
    sudo crouton -t e17,xiwi
    echo ""
    echo "Done installing second os (Ubunut-core)"
    echo ""
    echo "Installing"
fi

sleep 1

echo "Installing secondary files"
echo "1/11..."
sudo wget "$URL/commands/rootmount" --no-check-certificate -q
echo "2/11..."
sudo wget "$URL/commands/remount" --no-check-certificate -q
echo "3/11..."
sudo wget "$URL/commands/install" --no-check-certificate -q
echo "4/11..."
sudo wget "$URL/commands/remove" --no-check-certificate -q
echo "5/11..."
sudo wget "$URL/commands/run" --no-check-certificate -q
echo "6/11..."
sudo wget "$URL/commands/search" --no-check-certificate -q
echo "7/11..."
sudo wget "$URL/commands/stop" --no-check-certificate -q
echo "8/11..."
sudo wget "$URL/commands/uninstall" --no-check-certificate -q
echo "9/11..."
sudo wget "$URL/commands/update" --no-check-certificate -q
echo "10/11..."
sudo wget "$URL/commands/reinstall" --no-check-certificate -q
echo "11/11..."
sudo wget "$URL/cri" --no-check-certificate -q
echo "Done installing secondary files"
sleep 1
echo "Changing the permissions"
sudo chmod +x rootmount
sudo chmod +x remount
sudo chmod +x install
sudo chmod +x remove
sudo chmod +x run
sudo chmod +x search
sudo chmod +x stop
sudo chmod +x uninstall
sudo chmod +x update
sudo chmod +x reinstall
sudo chmod +x cri
echo "Done changing permissions"
echo ""
echo ""

sleep 2

echo "Changing the mounts to be root read/write"
echo "As soon as you mount your system as root reboot, the program will ask you in less"
echo "than 15 seconds"
sleep 15
sudo sh rootmount
