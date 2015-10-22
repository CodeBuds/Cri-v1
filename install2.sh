#!/bin/bash

CBIN=/usr/bin
URL="https://raw.github.com/CodeBuds/Cri/master"
CTEMP=~/Downloads/tmp #DO NOT CHANGE THIS TO ~/DOWNLOADS, WANNA KNOW WHY, LOOK AT BOTTOM OF SCRIPT

echo "Welcome to the second part of the installation"
echo "Developed by David Smerkous and Eli Smith"
sleep 1
echo "Starting..."
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

sudo mkdir $CTEMP
cd $CTEMP
echo "Downloading secondary files"
sudo wget -q --no-check-certificate "$URL/commands.txt" -O $CTEMP/commands.txt
sudo chmod 755 commands.txt
NAMES="$(< commands.txt)" #names from names.txt file
LINES=$(lineCount)
NUMBERS=0
cd $CBIN
for NAME in $NAMES; do
    echo "File $NUMBERS/$LINES..."
    let "NUMBERS += 1"
    sudo wget -q --no-check-certificate "$URL/$NAME" -O $CBIN/${NAME##*/}
    sudo chmod 755 ${NAME##*/}
done

sudo wget -q --no-check-certificate "$URL/runner" -O /mnt/stateful_partition/crouton/chroots/precise/usr/bin/runner
sudo chmod 755 /mnt/stateful_partition/crouton/chroots/precise/usr/bin/runner
echo "Done..."
echo

if ask "Would you like to fix the current config file?"; then
  sudo fixconfig
fi

if ask "Would you like to install the academy package? (HIGHLY RECOMMENDED), choose yes for list of packages"; then
  sudo acadapkg
fi
cd /usr/local/bin
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
    exec xinit /usr/bin/enlightenment_start' >starte17
sudo rm -rf $CTEMP
unset CTEMP
