                            -----------------------------------------------------------------
                            |                                                               |
                            |                     This repo is depricated,                  |
                            |                           Please use:                         |
                            |                <a href=">github.com/Pseudonymous-coders/CRI">github.com/Pseudonymous-coders/CRI</a>             |
                            |                                                               |
                            -----------------------------------------------------------------



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
Here is a list of all the commands that can be used in cri

Install a package using apt-get
```Shell
install <Ubuntu package name>
```
Search for a package
```Shell
search <Ubuntu package name>
```
Remove a package
```Shell
remove <Ubuntu package name>
```
Run a package
```Shell
run <Ubuntu package name>
```
Stop all processes
```Shell
stop
```
Update and upgrade the Ubuntu system<br>
```Shell
update
```
Update cri packages and pull from git(Must be connected to internet or it will mess up)
```Shell
updatecri
```
Unmount the Ubuntu system
```Shell
unmount
```
List locally installed packages
```Shell
packages
```
Uninstall everything
```Shell
uninstall
```
Opens the shell, just renamed to crishell
```Shell
crishell
```


##### Contact information
###### Eli Smith: plunkinguitar@gmail.com <br>
###### David Smerkous: smerkousdavid@gmail.com <br>
