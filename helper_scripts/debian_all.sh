#!/usr/bin/env bash


# License:      GPL
# Version:      0.1
#================================================

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}
ASK_INSTALL_MISSING () {
    WHIPTAIL --title "Missing packages" --yesno --scrolltext \
"These are the packages that need to be installed :\n${MISSING_DEP// /\n} \n
Want to install ? " 20 78
}

install_Debian()
{
    DEBIANDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev
    zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev
    python-imaging wv poppler-utils'
    MISSING_DEP=''
    for package in $DEBIANDEPS; do
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
        if [ "" == "$PKG_OK" ]; then
MISSING_DEP=$MISSING_DEP' '$package
        fi
done

APT_GET_INSTALL() {
    echo "Installing packages, please wait..."  >&3
    #su -c "apt-get update"
    su -c 'apt-get --force-yes --yes install $MISSING_DEP'
    return "$?"
}

if [ -n "$MISSING_DEP" ]; then
    ASK_INSTALL_MISSING
    givestatus=$?
    if [ $givestatus = 0 ]; then
        APT_GET_INSTALL
    else
        NO_INSTALL_WARNING
        error_exit
    fi
fi
}
install_Debian Wrapper for whiptail to display the interface on console
WHIPTAIL () {
    whiptail "$@" >&3
    return "$?"
}

README_MSG() {
    WHIPTAIL --title "Welcome" --yesno --scrolltext \
"This script will check for dependencies and if needed, install them.

Depending on your OS you will need root or sudo permissions.

For more information and options, re-run this script with --help

Do you want to continue ?" 20 78
}

README_GOODBYE() {
    WHIPTAIL --title "Goodbye" --msgbox \
"If you choose to install the requirements manually, see http://developer.plone.org" 20 78
}

GOODBYE() {
    WHIPTAIL --title "Dependencies installed" --msgbox \
"All missing dependencies have been installed.

Now, you're ready to install Plone itself.
For more support or information, please visit: https://plone.org/support" 20 78
}


HELP() {
    WHIPTAIL --title "Usage" --msgbox --scrolltext \
"This script will try to detect your OS, and will try to install all missing dependencies for Plone, \
using the package manager for your OS.

Depending on your OS this scripts needs sudo or root permissions.
If you don't know what sudo is, please read
https://en.wikipedia.org/wiki/Sudo

More information: http://developer.plone.org
Help and support: http://plone.org/support

(scroll down for more)

There are also some options available:
./install_dependencies.sh --ubuntu
./install_dependencies.sh --debian
./install_dependencies.sh --centos

These options will skip OS detection and will go straight to checking and installing dependencies" 20 78
}

OS_NOT_FOUND() {
    WHIPTAIL --title "Error" --msgbox "Sorry, unable to detect Operating System" 20 78
}

ASK_INSTALL_MISSING () {
    WHIPTAIL --title "Missing packages" --yesno --scrolltext \
"These are the packages that need to be installed :\n${MISSING_DEP// /\n} \n
Want to install ? " 20 78
}

ASK_INSTALL_MISSING_CENTOS () {
    WHIPTAIL --title "Missing packages" --yesno --scrolltext \
"These are the packages that need to be installed :\n${MISSING_CENTOSRPM// /\n} \n
Want to install ? " 20 78
}


NO_INSTALL_WARNING () {
    WHIPTAIL --title "Cancel" --msgbox  \
"You decided not to install missing dependencies via this script.

You can re-run this script, or install them manually." 20 78
}

# Info message, we use whiptail for that
CENTOS_SUCCESS() {
  WHIPTAIL --title "Dependencies installed" --msgbox "All missing dependencies have been installed.

Now, you are ready to install Plone itself.

Since you are using CentOS, please make sure to run the installer with --static-lxml

For support and more information, please visit: https://plone.org/support" 20 78
}
