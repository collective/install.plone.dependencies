#!/usr/bin/env bash
# Description:  check for OS and apply dependecies script
# License:      GPL
# Version:      0.1
#================================================

# Source other scripts
source check_ubuntu.sh

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

# Info message, we use whipetail for that
do_Readme() {
  whiptail --title "Check Dependencies" --yesno "Welcome, \n
This script will check your system for dependecies and if needed,
install them. \n
For more information you should check developer.plone org.
For help and support you should check plone.org/support.\n

This script is tested with Ubuntu 12.04 \n
You need to be root or have sudo permissions
Enjoy!" 20 78
readmestatus=$?
if [ $readmestatus = 1 ]; then
    error_exit "You decided not to install"
else
    :
fi
}

# Info message, we use whipetail for that
do_Farewell() {
  whiptail --title "Check Dependencies" --msgbox "All missing dependencies has been installed.\n
Now, You are ready to install Plone itself.\n\n\n
Farewell my friend and may the Force be with you!" 20 78
}

check_OS()
{
if [ -f "/etc/debian_version" ]; then
        LSB=$(lsb_release -c | egrep -o 'wheezy|squeeze|precise|quantal|raring')
        case $LSB in
                wheezy) OS='wheezy';;
                squeeze) OS='squeeze';;
                precise) OS='ubuntu';;
                quantal) OS='ubuntu';;
                raring)  OS='ubuntu';;
        esac
fi

if [ "$OS" == 'ubuntu' ]; then
    install_Ubuntu
else
    whiptail --title "Error" --msgbox "I am sorry but it seems you are not using Ubuntu" 20 78
    error_exit
fi
}