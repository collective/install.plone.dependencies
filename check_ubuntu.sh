#!/usr/bin/env bash
# Description:  check Ubuntu [12.04/12.10/13.04] for Plone dependencies
# License:      GPL
# Version:      0.1
#================================================

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

install_Ubuntu()
{
    Ubuntu='build-essential libssl-dev libxml2-dev libxslt1-dev \
    libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev \
    libreadline-gplv2-dev python-imaging wv poppler-utils'
    MISSING_UBUNTU=''
    for package in $UBUNTU; do
        PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
        if [ "" == "$PKG_OK" ]; then
           MISSING_UBUNTU=$MISSING_UBUNTU' '$package
        fi 
    done

    if [ -n "$MISSING_UBUNTU" ]; then
        whiptail --title "Info" --yesno "These are packages that need to be installed :\n${MISSING_UBUNTUDEPS// /\n} \n
        Do want to install these packages ? " 20 78
        if [ $givestatus = 0 ]; then
            sudo -S apt-get update
            sudo -S apt-get --force-yes --yes install $MISSING_UBUNTU
        else
         whiptail --title "Cancel" --msgbox "You decided not to install missing dependecies \n
         via this script, if you decide otherwise run this script again" 20 78
         error_exit
         fi
    fi  
}