#!/bin/sh
#Directories for all files
AUTHORS="David Smerkous and Eli Smith"
MODIFIERS="NONE"
URL="https://raw.github.com/CodeBuds/Cri/master"
CRIBIN=/usr/bin
CTEMP=~/Downloads/

cd $CTEMP
echo 'Welcome to the Cri installer, this will install Cri in 5 seconds, hit ctrl+z to stop if unwanted'
sleep 5

user=$(whoami)
architecture=$(uname -m)

echo "You are running as $user, and on a $architecture computer"
echo ""
echo "Developed by $AUTHORS"
echo ""

sleep 2

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
if ask "Is Cri already on your system?"; then
    echo "Installing secondary then..."
else
    echo "Installing pre files"
    sudo wget "https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton" --no-check-certificate -q
    echo "Done"
    echo "..."
    sleep 1
    echo
    echo
    sudo chmod +x crouton
    if ask "Do you have crouton already installed? if you select yes then we will wipe it..."; then
        echo "Installing..."
        sudo sh crouton -t xiwi -u -u
    else
        echo "Installing..."
        sudo sh crouton -t xiwi
    fi
    echo ""
    echo "Done installing second os (Ubuntu-core)"
    echo ""
    echo "Installing"
fi

sleep 1

cd $CTEMP
echo "Installing secondary files"
echo "1/12..."
sudo wget "$URL/commands/rootmount" --no-check-certificate -q
echo "2/12..."
sudo wget "$URL/commands/unmount" --no-check-certificate -q
echo "3/12..."
sudo wget "$URL/commands/install" --no-check-certificate -q
echo "4/12..."
sudo wget "$URL/commands/remove" --no-check-certificate -q
echo "5/12..."
sudo wget "$URL/commands/run" --no-check-certificate -q
echo "6/12..."
sudo wget "$URL/commands/search" --no-check-certificate -q
echo "7/12..."
sudo wget "$URL/commands/stop" --no-check-certificate -q
echo "8/12..."
sudo wget "$URL/commands/uninstall" --no-check-certificate -q
echo "9/12..."
sudo wget "$URL/commands/update" --no-check-certificate -q
echo "10/12..."
sudo wget "$URL/commands/reinstall" --no-check-certificate -q
echo "11/12..."
sudo wget "$URL/commands/crishell" --no-check-certificate -q
echo "12/12..."
sudo wget "$URL/cri" --no-check-certificate -q
echo "Done installing secondary files"
echo "Installing pre config files"
sudo wget "$URL/commands/fixconfig" --no-check-certificate -q
echo "Done installing pre config files"
echo "Installing updating package"
sudo wget "$URL/commands/updatecri" --no-check-certificate -q
echo "Done..."
sleep 1
cd $CTEMP
echo
echo
echo
echo
echo "To make any changed you will need remount as read and write, please read carefully"
sudo chmod +x rootmount
sudo cp rootmount /usr/local/bin
cd /usr/local/bin
sudo chmod +x rootmount
sleep 3
echo
echo
echo
echo
echo
echo
echo
echo
echo "PLEASE RUN THIS COMMAND BELOW TO FINISH PART ONE OF INSTALLATION..."
echo "Second part won't work until you do"
echo
echo
echo "rootmount"
echo
