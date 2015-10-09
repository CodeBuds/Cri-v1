#!/bin/sh

CBIN=/usr/bin

echo "Welcome to the second part of the installation"
echo "Developed by David Smerkous and Eli Smith"
sleep 1
echo "Changing directories"

cd 
cd Downloads
echo "Copying and Deleting commands"
echo ""
echo "1/11..."
sudo mv rootmount $CBIN
echo "2/11..."
sudo mv remount $CBIN
echo "3/11..."
sudo mv install $CBIN
echo "4/11..."
sudo mv remove $CBIN
echo "5/11..."
sudo mv run $CBIN
echo "6/11..."
sudo mv search $CBIN
echo "7/11..."
sudo mv stop $CBIN
echo "8/11..."
sudo mv uninstall $CBIN
echo "9/11..."
sudo mv update $CBIN
echo "10/11..."
sudo mv reinstall $CBIN
echo "11/11..."
sudo mv cri $CBIN
echo "Done copying and deleting"
echo "DONE..."

cd $CBIN
echo "Changing the permissions"
sudo chmod +x rootmount
sudo chmod +x unmount
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
