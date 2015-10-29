#!/bin/bash

CBIN=/usr/local/bin
CLIB=/usr/lib64
URL="https://raw.github.com/CodeBuds/Cri/master"
CTEMP=~/Downloads/.tmp #Keep this set to the .tmp so that nothing gets deleted
CROUBIN=/mnt/stateful_partition/crouton/chroots/precise/usr/bin
MEDURL="http://www.mediafire.com/download"

echo "Welcome to the second part of the installation"
echo "Developed by David Smerkous and Eli Smith"
sleep 1
echo "Starting..."
echo

ask() { #Same function called earlier in the previous script to use in yes/no situations
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

lineCount() #Same function called earlier in the previous script to use in the counting of lines in commands.txt
{
    wc -l < commands.txt	
}

lineCounttwo() #Same function called earlier in the previous script to use in the counting of lines in commands.txt
{
    wc -l < commands2.txt	
}
lineCountlib() #Same function called earlier in the previous script to use in the counting of lines in commands.txt
{
    wc -l < libs.txt	
}

libNames()
{
    cat libs.txt
}

if [ ! -d "$CTEMP" ]; then
    mkdir $CTEMP
fi 

#Gets all needed commands for Cri
cd $CTEMP
echo "Downloading Cri files" 
sudo wget -q --no-check-certificate "$URL/commands.txt" -O $CTEMP/commands.txt #This is to download list of files needed
sudo chmod 755 commands.txt #Makes the commands file have every permisson so that anyone can use it 
NAMES="$(< commands.txt)" #names from names.txt file
LINES=$(lineCount)
NUMBERS=1
cd $CBIN
for NAME in $NAMES; do #Downloads all nessisary files from github to /usr/local/bin
    echo "File $NUMBERS/$LINES..."
    let "NUMBERS += 1"
    sudo wget -q --no-check-certificate "$URL/$NAME" -O $CBIN/${NAME##*/}
    sudo chmod 755 ${NAME##*/}
done

#This next chunk installs certain files directly into the chroot 
cd $CTEMP
echo "Downloading crouton files" 
sudo wget -q --no-check-certificate "$URL/commands2.txt" -O $CTEMP/commands2.txt #This is to download list of files needed
sudo chmod 755 commands2.txt #Makes the commands file have every permisson so that anyone can use it 
NAMES="$(< commands2.txt)" #names from names.txt file
LINES=$(lineCounttwo)
NUMBERS=1
cd /mnt/stateful_partition/crouton/chroots/*/usr/bin
for NAME in $NAMES; do #Downloads all nessisary files from github to /usr/local/bin
    echo "File $NUMBERS/$LINES..."
    let "NUMBERS += 1"
    sudo wget -q --no-check-certificate "$URL/$NAME" -O ${NAME##*/}
    sudo chmod 755 ${NAME##*/}
done

#Gets needed libraries for Cri
cd $CTEMP
echo "Downloading lib files" 
sudo wget -q --no-check-certificate "$URL/libs.txt" -O $CTEMP/libs.txt #This is to download list of files needed
sudo chmod 755 libs.txt #Makes the commands file have every permisson so that anyone can use it 
NAMES=$(< libs.txt) #names from names.txt file
LINES=$(lineCountlib)
NUMBERS=1
cd $CLIB
for NAME in "$NAMES"; do #Downloads all nessisary files from github to /usr/local/bin
    echo "File $NUMBERS/$LINES..."
    let "NUMBERS += 1"
    sudo wget -q $NAME
    sudo chmod 755 $(echo "$NAME" | cut -d " " -f3)
done

cd $CBIN #Adds the "dialog" command to the bin
sudo wget -q https://www.dropbox.com/s/9be2q324fxzlz00/dialog?raw=1 -O dialog

#This makes it so that whenever ctrl+alt+t is pressed, http://download1339.mediafire.com/1y9uo9vg87tg/54t1f8e7wcl5hta/libncursesw.so.5we launch directly into Cri
cd $CBIN
sudo mv cri /usr/bin/crosh 
echo "Done..."
echo

if ask "Would you like to fix the current config file? (RECOMMENDED)"; then #Fixes the extention so that it works right 
  sudo fixconfig
fi

if ask "Would you like to install the academy package? (HIGHLY RECOMMENDED), choose yes for list of packages"; then
  sudo acadapkg
fi

cd $CBIN
sudo chmod 755 /usr/local/bin/starte17 &>/dev/null
sudo echo '#!/bin/sh -e
# Copyright (c) 2015 The crouton Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

APPLICATION=${0##*/}"

USAGE="$APPLICATION [options]

Wraps enter-chroot to start an e17 session.
By default, it will log into the primary user on the first chroot found.

Options are directly passed to enter-chroot; run enter-chroot to list them."

exec sh -e "`dirname "\`readlink -f "$0"\`"`/enter-chroot" -u root -t e17 "$@" "" \
    exec xinit /usr/bin/enlightenment_start' > /usr/local/bin/starte17
sudo chmod 755 ./*
cd ~/Downloads
sudo mkdir ~/Downloads/.tmp 2&>/dev/null
echo >~/Downloads/.tmp/coms
unset CTEMP
writer "(echo y+) % apt-get install dialog+(echo y+) % apt-get install thunar+(echo y+) % apt-get install gnome-icon-theme-extras+(echo y+) % apt-get install gnome-icon-theme-full"
sleep 0.5
sudo enter-chroot -u root runner
if ask "Done! Please restart your computer just to be safe, if you would like to, just hit y, if not press n"; then
    sudo reboot
else
    exit 0
fi
