# Cri
### Chrome Graphical Interface (Stable)
##### Developed by David Smerkous and Eli smith
##### (This has only been tested on CB30-A3120 Toshiba Chromebook and Toshiba Chromebook 2)
This is a *very* capable tool that utilizes the tool Crouton built and designed for Chromebooks

It is required to have the app <a href="https://chrome.google.com/webstore/detail/crouton-integration/gcpneefbbnfalgjniomfjknbcgkbijom" target="_new">Crouton integration</a> for anything to work. It is also recommended that you install the <a href="https://chrome.google.com/webstore/detail/crosh-window/nhbmpbdladcchdhkemlojfjdknjadhmh">Crosh Window</a> Extension for quick access.

This interface is a chrome end application to install and run Ubuntu applications without the need to run a seperate instance of Crouton/Ubuntu in the background or have it dual mounted.
This saves power and time with the ease of access we provide with this tool for Chrome OS <br>
___
To install Cri, first you need to put your system into Developer mode by follow this guide <a href="http://www.howtogeek.com/210817/how-to-enable-developer-mode-on-your-chromebook/" target="_new">here</a>

Then type in the command "shell" and follow the instructions below

Install Cri part 1 here:
```Shell
wget -q -O - https://raw.github.com/CodeBuds/Cri/master/install.sh | bash
```

Then, after that is done and run 'rootmount'
NOTE: you must reboot for the second part of the install to actually work
```Shell
wget -q -O - https://raw.github.com/CodeBuds/Cri/master/install2.sh | bash
```
_______
##### Usage
Here is a list of all the commands that can be used in cri, you can see most updated with 'help'
Install, to reference use same application name as apt-get, this installs a graphical application<br>

    install <Ubuntu package name>
Search, use same reference as above, this lists all similar packages and descriptions<br>

    search <Ubuntu package name>
Remove, use same reference as above, this removes specified packages<br>

    remove <Ubuntu package name>
Run, use same reference as above, run the graphical package<br>

    run <Ubuntu package name>
Stop, Stops all ubuntu processes<br>

    stop
Update, updates and upgrades ubuntu system<br>

    update
Updatecri, updates cri packages and pulls from git(Must be connected to internet or it will mess up)<br>

    updatecri
Unmount, unmounts ubuntu system<br>

    unmount
Lists locally installed packages<br>

    packages

Uninstalls everything<br>

    uninstall
Crishell, opens the shell, just renamed to crishell<br>

    crishell


##### Contact information
###### Eli Smith: plunkinguitar@gmail.com <br>
###### David Smerkous: smerkousdavid@gmail.com <br>
