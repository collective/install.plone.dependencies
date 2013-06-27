#!/usr/bin/env bash
# Description:  check for OS and apply dependecies script
# License:      GPL
# Version:      0.1
#================================================

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

# Info message, we use whipetail for that
README() {
  whiptail --title "Check Dependencies" --yesno --scrolltext "Welcome, \n
This script will check your system for dependecies and if needed,
install them. \n
For more information you should check developer.plone org.
For help and support you should check plone.org/support.\n

This script is tested with Ubuntu 12.04 \n
Depending on your OS You will need to have root or sudo permissions.\n
If you don't know what sudo is, please read \n
https://en.wikipedia.org/wiki/Sudo \n
Continue ?" 20 78
readmestatus=$?
if [ $readmestatus = 1 ]; then
    whiptail --title "Error" --msgbox "You decided to cancel this script" 8 78
    error_exit
else
    :
fi
}

# Info message, we use whipetail for that
FAREWELL() {
  whiptail --title "Check Dependencies" --msgbox "All missing dependencies has been installed.\n
Now, You are ready to install Plone itself.\n\n\n
Farewell my friend and may the Force be with you!" 20 78
}

HELP() {
  whiptail --title "Usage" --msgbox --scrolltext "This script will try to detect your OS. Scroll down ...\n
After detection it will try to install all missing dependencies for the Plone CMS.\n
Depending on your OS this scripts needs root or sudo permissions for some parts.\n\n\n
There are also some options available:\n
./install.sh --ubuntu\n
./install.sh --debian\n
./install.sh --centos\n\n
This options will skip most parts of the script and will straight check and intsall dependencies" 20 78
}

#TODO: add centos check
CHECK_OS()
{
if [ -f "/etc/debian_version" ]; then
        LSB=$(lsb_release -c | egrep -o 'wheezy|squeeze|precise|quantal|raring')
        case $LSB in
                wheezy) OS='wheezy';;
                precise) OS='ubuntu';;
                quantal) OS='ubuntu';;
                raring)  OS='ubuntu';;
        esac

elif [ -f "/etc/redhat-release" ]; then
    RHV=$(egrep -o 'Fedora|CentOS|Red.Hat' /etc/redhat-release)
    case $RHV in
        Fedora) OS='fedora';;
        CentOS) OS='centos';;
        Red.Hat) OS='redhat';;

    esac

fi

if [ "$OS" == 'ubuntu' ]; then
    . helper_scripts/check_ubuntu.sh
    #source check_ubuntu.sh
    #TODO: mv script to script dir and just call it,
    # rewrite function to 'just' a script
elif [ "$OS" == 'wheezy' ]; then
    . helper_scripts/check_debian.sh

elif [ "$OS" == 'centos' ]; then
    . helper_scripts/check_centos.sh

else
    whiptail --title "Error" --msgbox "I am sorry but I can't find out which OS this is" 20 78
    error_exit
fi
}
# Run the script with arguments or not for example:
# install_dependencies.sh --ubuntu
# use that only if you now what are you doing
case "$1" in
    "--ubuntu")
        CHECK_OS
        FAREWELL
    ;;

    "--debian")
        check_OS
        FAREWELL
    ;;

    "--centos")
        CHECK_OS
    ;;

    "--help")
        HELP
    ;;

    "")
        README
        CHECK_OS
        FAREWELL
    ;;
esac

