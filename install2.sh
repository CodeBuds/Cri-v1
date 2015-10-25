#!/bin/bash

CBIN=/usr/local/bin
URL="https://raw.github.com/CodeBuds/Cri/master"
CTEMP=~/Downloads/.tmp #Keep this set to the .tmp so that nothing gets deleted
CROUBIN=/mnt/stateful_partition/crouton/chroots/precise/usr/bin

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

if [ ! -d "$CTEMP" ]; then
    mkdir $CTEMP
fi 

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
sudo wget -q --no-check-certificate "$URL/runner" -O /mnt/stateful_partition/crouton/chroots/precise/usr/bin/runner
sudo chmod 755 /mnt/stateful_partition/crouton/chroots/precise/usr/bin/runner
sudo wget -q --no-check-certificate "$URL/gui-cri" -O /mnt/stateful_partition/crouton/chroots/precise/usr/bin/gui-cri
sudo chmod 755 /mnt/stateful_partition/crouton/chroots/precise/usr/bin/gui-cri
sudo wget -q --no-check-certificate "$URL/commands/netlogo" -O /mnt/stateful_partition/crouton/chroots/precise/usr/bin/netlogo
sudo chmod 755 /mnt/stateful_partition/crouton/chroots/precise/usr/bin/netlogo
sudo wget -q --no-check-certificate "$URL/commands/energia" -O /mnt/stateful_partition/crouton/chroots/precise/usr/bin/energia
sudo chmod 755 /mnt/stateful_partition/crouton/chroots/precise/usr/bin/energia
sudo wget -q --no-check-certificate "$URL/commands/processing" -O /mnt/stateful_partition/crouton/chroots/precise/usr/bin/processing
sudo chmod 755 /mnt/stateful_partition/crouton/chroots/precise/usr/bin/processing

cd $CBIN
sudo mv cri /usr/bin/crosh #This makes it so that whenever ctrl+alt+t is pressed, we launch directly into Cri
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
cd ~/Downloads
unset CTEMP
writer "(echo y+) % apt-get install dialog+(echo y+) % apt-get install thunar+(echo y+) % apt-get install gnome-icon-theme-extras+(echo y+) % apt-get install gnome-icon-theme-full"
sleep 0.5
sudo enter-chroot -u root runner
if ask "Done! Please restart your computer just to be safe, if you would like to, just hit y, if not press n"; then
    sudo reboot
else
    exit 0
fi
