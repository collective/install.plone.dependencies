#!/usr/bin/env bash
# Description:  will check and install Plone [http://plone.org] dependencies
# License:      GPL
# Version:      0.1.b1
#================================================


# Check if user is root or using sudo
# Sanity Check: Test if the script runs as root
if [ "$(whoami)" != root ] ; then
    echo -n "\nPlease run this script as root!\n" >&amp;2
    exit 1
fi


# First some functions ....
#===========================

installPrecise()
{
    PRECISEDEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils'
    for package in $PRECISEDEPS; do
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
    #dpkg-query -l $package
    echo Checking for $package: $PKG_OK
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $package"
        #apt-get --force-yes --yes install $package
    fi
done
}

# We should support Squeeze only till Wheezy is released as 'stable'
installSqueeze()
{
    SQUEEZEDEBS='build-essential wv poppler-utils python2.6-dev python-imaging libssl-dev libjpeg62-dev zlib1g-dev libreadline5-dev libxml2-dev python-libxml2 libxslt1-dev python-libxslt1 libpcre3 libpcre3-dev xpdf-utils libreadline5 zlib1g  libjpeg62 libssl0.9.8 cron groff-base python-dev'
    for package in $SQUEEZEDEBS; do
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
    echo Checking for $package: $PKG_OK
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $package"
        #apt-get --force-yes --yes $package
    fi
done
}



# Here we will try to figure out which OS it is we are talking about
# and assigning the right function to the right OS
#=====================================================================


#checkDEBIAN

#todo:
#function for fedora
#include check os script
#cleanup the debian/ubuntu mess
#split debian and ubuntu, for this we have to tweak the check os script/function
#add centos


