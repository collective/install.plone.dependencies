#!/usr/bin/env bash
# Description:  check Debian [7] for Plone dependencies
# License:      GPL
# Version:      0.1
#================================================

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}


install_Debian()
{
    DEBIANDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils'
    MISSING_DEP=''
    for package in $DEBIANDEPS; do
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
        if [ "" == "$PKG_OK" ]; then
MISSING_DEP=$MISSING_DEP' '$package
        fi
done

if [ -n "$MISSING_DEP" ]; then
whiptail --title "Info" --yesno --scrolltext "These are packages that need to be installed :\n${MISSING_DEP// /\n} \n
Want to install ? " 20 78
        givestatus=$?
        if [ $givestatus = 0 ]; then
            su -c apt-get update
            #sudo -S apt-get update #we use sudo as default on ubuntu not on debian
            #su -c apt-get --force-yes --yes install $MISSING_DEP
            #sudo -K # remove sudo timestamp
            #TODO: create here a popup, if passwd is false
            # make oneline out of above lines
        else
            whiptail --title "Cancel" --msgbox "You decided not to install missing dependecies \n
         via this script, if you decide otherwise run this script again" 8 78
         error_exit
        fi
fi
}
install_Debian
