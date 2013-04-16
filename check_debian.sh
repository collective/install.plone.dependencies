#!/usr/bin/env bash
# Description:  check Debian [6/7] for Plone dependencies
# License:      GPL
# Version:      0.1
#================================================
# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

install_Squeeze()
{
    SQUEEZE='build-essential wv poppler-utils python2.6-dev \
    python-imaginglibssl-dev libjpeg62-dev zlib1g-dev \
    libreadline5-dev libxml2-dev python-libxml2 libxslt1-dev \
    python-libxslt1 libpcre3 libpcre3-dev xpdf-utils \
    libreadline5 zlib1g  libjpeg62 libssl0.9.8 cron groff-base \
    python-dev'
    MISSING_SQUEEZE=''
    for package in $SQUEEZE; do
        PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
        if [ "" == "$PKG_OK" ]; then
            MISSING_SQUEEZE=$MISSING_SQUEEZE' '$package
        fi
    done

    if [ -n "$MISSING_SQUEEZE" ]; then
        whiptail --title "Info" --yesno "These are packages that need to be installed :\n${MISSING_SQUEEZE// /\n} \n
        Want to install ? " 20 78
        givestatus=$?
        if [ $givestatus = 0 ]; then
            apt-get update
            apt-get --force-yes --yes install $MISSING_SQUEEZE
            #TODO:for debian make sure to use root [su[ and sudo as an option
        else
            error_exit "You decided not to install"
        fi
    fi
}
