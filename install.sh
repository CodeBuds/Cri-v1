#!/bin/bash
AUTHORS="David Smerkous and Eli Smith"
URL="https://raw.github.com/CodeBuds/Cri/master"
CRIBIN=/usr/bin
CTEMP=~/Downloads/tmp
CROUTON=/mnt/stateful_partition/crouton  
URLCROUTON="https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton"

sudo mkdir $CTEMP
cd $CTEMP
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

lineCount()
{
    wc -l < commands.txt	
}

cd $CTEMP
if ask "Would you like to install cri?"; then
	echo "Preparing for installation..."
	echo
	sudo wget -q --no-check-certificate $URLCROUTON -O $CTEMP/crouton
	sudo chmod 755 crouton
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
sudo wget -q --no-check-certificate "$URL/commands/rootmount" -O $CTEMP/rootmount
sudo chmod 755 rootmount
sudo cp rootmount /usr/local/bin
cd /usr/local/bin
sudo chmod 755 rootmount
if ask "Would you like to mount as root(Required if not done)?"; then
   rootmount
else
   echo
   if ask "Then would you like to install part two?"; then
   	wget -q -O - https://raw.github.com/CodeBuds/Cri/master/install2.sh | bash
   fi
fi

