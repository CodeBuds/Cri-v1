#!/bin/bash
AUTHORS="David Smerkous and Eli Smith"
URL="https://raw.github.com/CodeBuds/Cri/master"
CBIN=/usr/bin
CTEMP=~/Downloads/.tmp
CROUTON=/mnt/stateful_partition/crouton  
URLCROUTON="https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton"

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
sudo wget -q --no-check-certificate $URLCROUTON -O $CTEMP/crouton
sudo chmod 755 crouton
echo "Downloading...."
if [ ! -d "$CROUTON" ]; then #Installs crouton
	    sudo sh crouton -t xiwi,extension,e17
else
	    sudo sh crouton -t xiwi,extension,e17 -u
fi

user\n
password\n

cd ~/Downloads/.tmp
sudo rm rootmount*
sudo wget -q --no-check-certificate "$URL/commands/rootmount" -O rootmount #This is a crutial step to mount root
sudo chmod 755 rootmount	#Into Read/write so we can modify system

if [ -d /home/chronos/user/Extensions/nhbmpbdladcchdhkemlojfjdknjadhmh ]; then
	echo "Installing icons..."
	cd /home/chronos/user/Extensions/nhbmpbdladcchdhkemlojfjdknjadhmh/*/
	sudo rm -f icon_128.png
	sudo rm -f icon_16.png
	sudo wget -q https://www.dropbox.com/s/q8ga4jgwih9980a/icon_128.png?dl=1 -O icon_128.png
	sudo wget -q https://www.dropbox.com/s/q8ga4jgwih9980a/icon_128.png?dl=1 -O icon_16.png
fi

	


cd /usr/local/bin
sudo cp $CTEMP/rootmount /usr/local/bin/
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
