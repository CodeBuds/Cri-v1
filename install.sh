#!/bin/bash
AUTHORS="David Smerkous and Eli Smith"
URL="https://raw.github.com/CodeBuds/Cri/master"
CBIN=/usr/local/bin
CTEMP=~/Downloads/.tmp
CROUTON=/mnt/stateful_partition/crouton  
URLCROUTON="https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton"

if [ -d "$CBIN" ]; then #Checks if the directory was there before (ex. prior crouton installation)
	sudo rm -rf $CBIN
	sudo mkdir $CBIN         #If there is no directory, we make one
fi
mkdir $CTEMP
sudo chmod +x ~/Downloads/.tmp
cd $CTEMP
user=$(whoami)
echo "Welcome to the Cri installer"
echo "Developed by $AUTHORS"
sleep 0.5
echo "You are running as $user"
echo

ask() {				   #This is the function we call for our yes/no situations 
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

lineCount()			   #This is used to count the number of lines in the commands.txt file
{
    wc -l < commands.txt	
}

cd $CTEMP
if ask "Would you like to install cri?"; then #Goes through the process of installing crouton 
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

user
password

cd $CTEMP
sudo wget -q --no-check-certificate "$URL/commands/rootmount" -O $CTEMP/rootmount #This is a crutial step to mount root
sudo chmod 755 rootmount							  #Into Read/write so we can modify system
if [ ! -d "/usr/local/bin" ]; then
	sudo mkdir /usr/local/bin
fi 
cd $CBIN
sudo cp $CTEMP/rootmount ./
sudo chmod 755 rootmount
if ask "Would you like to mount as root(Required if not done)?"; then
   rootmount			   #This actually mounts the system to RW, must be done twice, once before reboot, once after
else
   echo
   if ask "Then would you like to install part two?"; then
   	wget -q -O - https://raw.github.com/CodeBuds/Cri/master/install2.sh | bash #Installs part two of the installation
   fi
fi
unset CTEMP
unset CBIN
