#!/usr/bin/env bash
# Description:  check Ubuntu [12.04/12.10/13.04] for Plone dependencies
# License:      GPL
# Version:      0.1
#================================================

# Those are the messages for whiptail
. whiptail_messages.sh


# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

dry_install_Ubuntu()
{
    UBUNTUDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev
    zlib1g-dev python-setuptools python-dev libjpeg62-dev
    libreadline-gplv2-dev python-imaging wv poppler-utils'
    MISSING_DEP=''
    for package in $UBUNTUDEPS; do
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
        if [ "" == "$PKG_OK" ]; then
MISSING_DEP=$MISSING_DEP' '$package
        fi
done

APT_GET_DRY_RUN() {
    echo "Updating packages, please wait..."  >&3
    sudo apt-get install --dry-run
    return "$?"
}

CANNOT_APT_GET_INSTALL() {
    error_exit "Cannot continue... check $LOGFILE"  >&3
}

if [ -n "$MISSING_DEP" ]; then
#    ASK_INSTALL_MISSING
    givestatus=$?
    if [ $givestatus = 0 ]; then
        sudo -v && APT_GET_DRY_RUN || CANNOT_APT_GET_INSTALL 2>&4
        sudo -K
    else
        error_exit
    fi
fi
}
dry_install_Ubuntu
