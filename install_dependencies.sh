#!/usr/bin/env bash
# Description:  check for OS and apply dependecies script
# License:      GPL
# Version:      0.1
#================================================
LOGFILE="install.log"

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

# We want the redirect everything to a file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1> $LOGFILE 2>&1

# Wrapper for whiptail to display the interface
WHIPTAIL () {
    whiptail "$@" >&3
    return "$?"
}

README() {
  WHIPTAIL --title "Check Dependencies" --yesno --scrolltext "Welcome, \n
This script will check your system for dependecies and if needed,
install them. \n
For more information you should check developer.plone org.
For help and support you should check plone.org/support.\n

Depending on your OS You will need to have root or sudo permissions.\n
If you don't know what sudo is, please read \n
https://en.wikipedia.org/wiki/Sudo \n
Do you want to continue ?" 20 78
readmestatus=$?
if [ $readmestatus = 1 ]; then
    WHIPTAIL --title "Error" --msgbox "Sad to see you go ..." 8 78
    error_exit
else
    :
fi
}

GOODBYE() {
  WHIPTAIL --title "Check Dependencies" --msgbox "All missing dependencies have been installed.\n
Now, You are ready to install Plone itself.\n\n\n
For more support or information, please visit: https://plone.org/support" 20 78
}

HELP() {
  WHIPTAIL --title "Usage" --msgbox --scrolltext "This script will try to detect your OS.\n
After detection it will try to install all missing dependencies for the Plone CMS.\n
Depending on your OS this scripts needs root or sudo permissions for some parts.\n\n\n
There are also some options available:\n
./install.sh --ubuntu\n
./install.sh --debian\n
./install.sh --centos\n\n
This options will skip most parts of the script and will straight check and intsall dependencies" 20 78
}

CHECK_OS()
{
if [ -f "/etc/debian_version" ]; then
        LSB=$(lsb_release -c | egrep -o 'wheezy|jessie|precise|quantal|raring')
        case $LSB in
                wheezy) OS='debian';;
                jessie) OS='debian';;
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
elif [ "$OS" == 'debian' ]; then
    . helper_scripts/check_debian.sh
elif [ "$OS" == 'centos' ]; then
    . helper_scripts/check_centos.sh

else
    WHIPTAIL --title "Error" --msgbox "I am sorry but I can't find out which OS this is" 20 78
    error_exit
fi
}
# Run the script with arguments or not for example:
# install_dependencies.sh --ubuntu
# use that only if you now what are you doing
case "$1" in
    "--ubuntu")
        CHECK_OS
        GOODBYE
    ;;

    "--debian")
        check_OS
        GOODBYE
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
        GOODBYE
    ;;
esac

