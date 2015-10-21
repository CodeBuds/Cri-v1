#!/bin/sh

CBIN=/usr/bin
CTEMP=~/Downloads/tmp #DO NOT CHANGE THIS TO ~/DOWNLOADS, WANNA KNOW WHY, LOOK AT BOTTOM OF SCRIPT

echo "Welcome to the second part of the installation"
echo "Developed by David Smerkous and Eli Smith"
sleep 1
echo "Starting..."
echo

lineCount()
{
    wc -l < commands.txt	
}

cd $CBIN
echo "Downloading secondary files"
sudo wget -q --no-check-certificate "$URL/commands.txt" -O $CTEMP/commands.txt
sudo chmod 755 commands.txt
NAMES="$(< commands.txt)" #names from names.txt file
LINES=$(lineCount)
NUMBERS=0
for NAME in $NAMES; do
    echo "File $NUMBERS/$LINES..."
    let "NUMBERS += 1"
    sudo wget -q --no-check-certificate "$URL/$NAME" -O $CBIN/${NAME##*/}
    sudo chmod 755 ${NAME##*/}
done
echo "Done..."
echo

if ask "Would you like to fix the current config file?"; then
  sudo fixconfig
fi

if ask "Would you like to install the academy package? (HIGHLY RECOMMENDED), choose yes for list of packages"; then
  sudo acadapkg
fi
sudo rm -rf $CTEMP
