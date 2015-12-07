#!/bin/bash

AUTHORS="David Smerkous and Eli Smith"
URL="https://raw.github.com/CodeBuds/Cri/master"
CBIN=/usr/bin
CLOCAL=/usr/local/bin
CTEMP=~/Downloads/.tmp
CROUTON=/mnt/stateful_partition/crouton  
URLCROUTON="https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton"
EXTENSION=/home/chronos/user/Extensions/nhbmpbdladcchdhkemlojfjdknjadhmh
user=$(whoami)

mkdir $CTEMP 2&> /dev/null
sudo chmod +x ~/Downloads/.tmp 2&> /dev/null
cd $CTEMP
printf "Welcome to the Cri installer\nDeveloped by $AUTHORS \nYou are running as $user \n"

ask() {				   #This is the function we call for our yes/no situations 
    while true; do
        read -p "$1?[y/n] " REPLY </dev/tty
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
sudo su -c "wget -q --no-check-certificate $URLCROUTON -O $CTEMP/crouton;chmod 755 crouton"
echo "Downloading...."
if [ ! -d "$CROUTON" ]; then #Installs crouton
	sudo su -c "sh crouton -t xiwi,extension,e17"
else
	sudo su -c "sh crouton -t xiwi,extension,e17 -u"
fi

user\n
password\n

cd $CTEMP
sudo rm rootmount*
sudo wget -q --no-check-certificate "$URL/commands/rootmount" -O rootmount #This is a crutial step to mount root
sudo chmod 755 rootmount	#Into Read/write so we can modify system

if [ -d  $EXTENSION ]; then
	echo "Installing icons..."
	cd $EXTENSION/*/
	sudo su -c "rm -f icon_128.png;
	rm -f icon_16.png;
	wget -q https://www.dropbox.com/s/q8ga4jgwih9980a/icon_128.png?dl=1 -O icon_128.png;
	wget -q https://www.dropbox.com/s/q8ga4jgwih9980a/icon_128.png?dl=1 -O icon_16.png"
fi

	


cd $CLOCAL
sudo su -c "cp $CTEMP/rootmount $CLOCAL;chmod 755 rootmount;rootmount"
printf "We just ran the command rootmount, it should have been unsuccessful, make sure you rerun the command on next boot up\n\n"
if ask "We need to reboot... Is that okay"; then
	sudo reboot
else
	echo "Okay, just remember to reboot and run rootmount until it says it's successful"
fi
unset CTEMP
unset CBIN
