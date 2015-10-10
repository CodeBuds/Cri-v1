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
echo "1/12..."
sudo mv rootmount $CBIN
echo "2/12..."
sudo mv unmount $CBIN
echo "3/12..."
sudo mv install $CBIN
echo "4/12..."
sudo mv remove $CBIN
echo "5/12..."
sudo mv run $CBIN
echo "6/12..."
sudo mv search $CBIN
echo "7/12..."
sudo mv stop $CBIN
echo "8/12..."
sudo mv uninstall $CBIN
echo "9/12..."
sudo mv update $CBIN
echo "10/12..."
sudo mv reinstall $CBIN
echo "11/12..."
sudo mv crishell $CBIN
echo "12/12..."
sudo mv cri $CBIN/crosh
echo "Done copying and deleting main files"
echo "Moving config files"
sudo mv fixconfig $CBIN
sudo mv updatecri $CBIN
sudo mv acadapkg $CBIN
echo "Moving apps"
sudo mv netlogo $CBIN
sudo mv thunar $CBIN
echo "Done"
ask() {
    # http://djm.me/ask
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "$1 [$prompt] " REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}
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
sudo chmod +x crishell
sudo chmod +x fixconfig
sudo chmod +x crosh
sudo chmod +x updatecri
sudo chmod +x acadapkg
sudo chmod +x netlogo
sudo chmod +x thunar
echo "Done changing permissions"
echo "DONE..."
echo ""
echo ""

if ask "Would you like to fix the current config file?"; then
  sudo fixconfig
fi

if ask "Would you like to install the academy package?"; then
  sudo acadapkg
fi
