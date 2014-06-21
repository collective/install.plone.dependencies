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
    UBUNTUDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev
    zlib1g-dev python-dev libjpeg62-dev libz-dev
    libreadline-gplv2-dev wv poppler-utils'
    MISSING_DEP=''
    for package in $UBUNTUDEPS; do
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
        if [ "" == "$PKG_OK" ]; then
MISSING_DEP=$MISSING_DEP' '$package
        fi
done

APT_GET_INSTALL() {
    echo "Installing packages, please wait..."  >&3
    sudo apt-get --force-yes --yes install $MISSING_DEP
    return "$?"
}

CANNOT_APT_GET_INSTALL() {
    error_exit "Cannot continue... check $LOGFILE"  >&3
}

if [ -n "$MISSING_DEP" ]; then
    ASK_INSTALL_MISSING
    givestatus=$?
    if [ $givestatus = 0 ]; then
        sudo -v && APT_GET_INSTALL || CANNOT_APT_GET_INSTALL 2>&4
        #sudo apt-get --force-yes --yes install $MISSING_DEP
        sudo -K
    else
        NO_INSTALL_WARNING
        error_exit
    fi
fi
}
install_Ubuntu
