#!/bin/bash

# Check if user is root or using sudo
# Sanity Check: Test if the script runs as root
if [ "$(whoami)" != root ] ; then
    echo -e "\033[33;31m Please run this script as root or with sudo"
    #echo "Please run this script as root!"
    exit 1
fi

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}


install_Ubuntu()
{
    UBUNTUDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils'
    for package in $UBUNTUDEPS; do
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
    #dpkg-query -l $package
    #echo "Checking for packages, please wait"
    whiptail --title "Info" --msgbox "Checking for \n
    "$package":"$PKG_OK" \n
    Want to install ? " 20 78
    #echo Checking for $package: $PKG_OK
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $package"
        #apt-get --force-yes --yes install $package
    fi
done
}

# info message, we use whipetail for that
do_Readme() {
  whiptail --title "Check Dependencies" --msgbox "Welcome, \n
This script will check your system for dependecies and if needed,
install them. \n
For more information you should check developer.plone org.
For help and support you should check plone.org/support.\n

This script is tested with Ubuntu 12.04 \n
You need to be root or have sudo permissions
Enjoy!" 20 78
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
    ;;
esac
