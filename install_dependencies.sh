#!/bin/bash

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

# Check if user is root or using sudo
# Sanity Check: Test if the script runs as root
if [ "$(whoami)" != root ] ; then
    echo -e "\033[33;31m Please run this script as root or with sudo"
    #echo "Please run this script as root!"
    #exit 1
    error_exit
fi

install_Ubuntu()
{
    UBUNTUDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils'
    MISSING_DEP=''
    for package in $UBUNTUDEPS; do
        PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
    #    PKG_OK=$(apt-cache search --installed $package)
        #dpkg-query -l $package
        #echo "Checking for packages, please wait"
    #    whiptail --title "Info" --msgbox "Checking for \n
    #    "$package":"$PKG_OK" \n
    #    Want to install ? " 20 78
    #    #echo Checking for $package: $PKG_OK
        if [ "" == "$PKG_OK" ]; then
    #    if [ -n "$PKG_OK" ]; then
    #        echo "Installing $package"
            MISSING_DEP=$MISSING_DEP' '$package
#            echo $MISSING_DEP
        fi
    done
#    echo $MISSING_DEP
    if [ -n "$MISSING_DEP" ]; then
        whiptail --title "Info" --yesno "These are packages that need to be installed :\n${MISSING_DEP// /\n} \n
        Want to install ? " 20 78
        givestatus=$?
        if [ $givestatus = 0 ]; then
            apt-get update
            apt-get --force-yes --yes install $MISSING_DEP
        else
            error_exit "It decided not to install" # ask to move on?
        fi
    fi
}

# info message, we use whipetail for that
do_Readme() {
  whiptail --title "Check Dependencies" --msgbox "Welcome, \n
This script will check your system for dependecies and if needed,
install them. \n
For more information you should check developer.plone org.
For help and support you should check plone.org/support.\n

This script is tested with Ubuntu versions 12.04, 13.04 \n
You need to be root or have sudo permissions
Enjoy!" 20 78
}

# info message, we use whipetail for that
do_Farewell() {
  whiptail --title "Check Dependencies" --msgbox "All missing dependencies has been installed.\n
Now, You are ready to install Plone itself.\n\n\n
Farewell my friend and may the Force be with you!" 20 78
}


# check if ubuntu [debian check will come later]
check_OS()
{
if [ -f "/etc/debian_version" ]; then
        LSB=$(lsb_release -c | egrep -o 'wheezy|precise|squeeze|quantal')
        case $LSB in
                wheezy) OS='wheezy';;
                squeeze) OS='squeeze';;
                precise) OS='ubuntu';;
                quantal) OS='ubuntu';;
        esac
fi

if [ "$OS" == 'ubuntu' ]; then
        install_Ubuntu
else
        error_exit "It seems your OS is not Ubuntu"
fi
}

# run the script with arguments or not for example
# install_dependencies.sh --ubuntu, use that only if you now
# what are you doing
case "$1" in
    "--ubuntu")
        check_OS
    ;;

    "")
        do_Readme
        check_OS
        do_Farewell
    ;;
esac
