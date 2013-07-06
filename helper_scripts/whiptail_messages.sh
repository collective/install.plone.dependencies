#!/bin/sh
# Wrapper for whiptail to display the interface on console
WHIPTAIL () {
    whiptail "$@" >&3
    return "$?"
}

README_MSG() {
    WHIPTAIL --title "Check Dependencies" --yesno --scrolltext \
"Welcome, \n
This script will check your system for dependecies and if needed,
install them. \n
For more information you should check developer.plone org.
For help and support you should check plone.org/support.\n

Depending on your OS You will need to have root or sudo permissions.\n
If you don't know what sudo is, please read \n
https://en.wikipedia.org/wiki/Sudo \n
Do you want to continue ?" 20 78
}

README_GOODBYE() {
    WHIPTAIL --title "Error" --msgbox "Sad to see you go ..." 8 78
}

GOODBYE() {
    WHIPTAIL --title "Check Dependencies" --msgbox \
"All missing dependencies have been installed.\n
Now, You are ready to install Plone itself.\n\n\n
For more support or information, please visit: https://plone.org/support" 20 78
}


HELP() {
    WHIPTAIL --title "Usage" --msgbox --scrolltext \
"This script will try to detect your OS.\n
After detection it will try to install all missing dependencies for the Plone CMS.\n
Depending on your OS this scripts needs root or sudo permissions for some parts.\n\n\n
There are also some options available:\n
./install.sh --ubuntu\n
./install.sh --debian\n
./install.sh --centos\n\n
This options will skip most parts of the script and will straight check and intsall dependencies" 20 78
}

OS_NOT_FOUND() {
    WHIPTAIL --title "Error" --msgbox "I am sorry but I can't find out which OS this is" 20 78
    error_exit
}

ASK_INSTALL_MISSING () {
    WHIPTAIL --title "Info" --yesno --scrolltext \
"These are packages that need to be installed :\n${MISSING_DEP// /\n} \n
Want to install ? " 20 78
}

NO_INSTALL_WARNING () {
    WHIPTAIL --title "Cancel" --msgbox "You decided not to install missing dependecies \n
    via this script, if you decide otherwise run this script again" 8 78
}

# Info message, we use whipetail for that
CENTOS_SUCCESS() {
  WHIPTAIL --title "Check Dependencies" --msgbox "All missing dependencies have been installed.\n
Now, You are ready to install Plone itself.\n\n\n
Since you are using CentOS, please make sure to run the installer with --static-lxml\n\n\n
For support and more information, please visit: https://plone.org/support" 20 78
}
