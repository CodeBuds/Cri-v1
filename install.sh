#!/bin/sh
AUTHORS="David Smerkous and Eli Smith"
URL="https://raw.github.com/CodeBuds/Cri/master"
CRIBIN=/usr/bin
CTEMP=~/Downloads/tmp
CROUTON=/mnt/stateful_partition/crouton  
URLCROUTON="https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton"

sudo mkdir $CTEMP && cd $CTEMP
user=$(whoami)
echo "Welcome to the Cri installer"
echo "You are running as $user, and on a $architecture computer"
echo "Developed by $AUTHORS"
echo

ask() {
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
        read -p "$1 [$prompt] " REPLY </dev/tty
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

if ask "Would you like to install cri?"; then
	echo "Preparing for installation..."
	echo
	sudo wget -q --no-check-certificate $URLCROUTON -O $CTEMP/crouton
	sudo chmod +x crouton
	if [ ! -d "$CROUTON" ]; then
		echo
		if ask "It looks like xiwi isn't installed would you like to install it (xiwi is a requirement for cri)?"; then
		    echo "Trying..."
		    sudo sh crouton -t xiwi,extension,e17
		fi
	else
		echo
		if ask "It looks like crouton is already installed, we need to update it, is that okay?"; then
		    echo "Trying..."
		    sudo sh crouton -t xiwi,extension,e17 -u
		fi	    
	fi
else
	echo "Exiting..."
	exit
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
echo
echo "Installing pre config files"
sudo wget "$URL/commands/fixconfig" --no-check-certificate -q
sudo wget "$URL/commands/Xfix" --no-check-certificate -q
echo "Done installing pre config files"
echo
echo
echo "Installing updating package"
sudo wget "$URL/commands/updatecri" --no-check-certificate -q
sudo wget "$URL/commands/acadapkg" --no-check-certificate -q
echo "Done Installing updating packages"
echo
echo
echo "Installing apps"
sudo wget "$URL/commands/netlogo" --no-check-certificate -q
sudo wget "$URL/apps/thunar" --no-check-certificate -q
echo "Done..."

cd $CTEMP
echo
echo "To make any changed you will need remount as read and write, please read carefully"
sudo chmod +x rootmount
sudo cp rootmount /usr/local/bin
cd /usr/local/bin
sudo chmod +x rootmount
sleep 2
echo
echo
echo "PLEASE RUN THIS COMMAND BELOW TO FINISH PART ONE OF INSTALLATION..."
echo "Second part won't work until you do"
echo
echo "rootmount"
echo
