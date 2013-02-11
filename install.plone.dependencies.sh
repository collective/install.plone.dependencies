#!/bin/bash
# Inspired by:  http://www.mirkopagliai.it/
# Description:  will check and install Plone [http://plone.org] dependencies
# License:      GPL
# Version:      0.1.b1
#================================================

# Colors
#txtrst=$(tput sgr0) # Text reset
#txtred=$(tput setaf 1) # Red

#echo “Welcome to ${txtred} Checking for missing Dependencies .... ${txtrst}!”

# First some functions ....
#===========================
# Debian/Ubuntu
debianINST()
{
    # List of Dependencies to Install
    DEPENDENCIES=(build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils)

    #apt-get runs in quiet mode to avoid lots of output
    #echo -n "Updating System ..."
    #apt-get -q -q update

    # check them ....
    PKGSTOINSTALL=""
    for (( i=0; i<${tLen=${#DEPENDENCIES[@]}}; i++ )); do
    #for (( i=0; i<${tLen=${#APT_FILES[@]}}; i++ )); do
    #for i in "$APT_FILES"; do
    #for i in "${APT_FILES[@]}"; do
        if [[ ! `dpkg -l | grep -w "ii  ${DEPENDENCIES[$i]} "` ]]; then
            PKGSTOINSTALL=$PKGSTOINSTALL" "${DEPENDENCIES[$i]}
        else
        PKGSTOINSTALL=$PKGSTOINSTALL" "${DEPENDENCIES[$i]}
        fi

    #echo -n "${packages}"
    #dpkg -l "${packages}"
    #PKG_OK=$(dpkg-query -W --showformat='${Status}\n' | grep -q "install ok installed")
    #PKG_OK=$(dpkg-query -W --showformat='${Status}\n'${APT_FILES[$i]} | grep -q "install ok installed")
    #if dpkg-query -Wf'${db:Status-abbrev}'2>/dev/null | grep -q '^i' ; then
    #    printf 'Why yes, the package "%s" _is_ installed!\n' "$packages"
    #else
    #    printf 'I regret to inform you that the packages "%s" are not currently installed.\n' "$packages"
    #fi
    #$PKG_OK
    #if [ "" = "$PKG_OK" ]; then
    #    echo "No somelib. Setting up somelib."
        #sudo apt-get --force-yes --yes install "${APT_FILES}"
        #echo -n "Installing missing Dependencies "${APT_FILES}""
    #else
    #    echo -n "busted"

    done
    # If some dependencies are missing, install them
    if [ "$PKGSTOINSTALL" != "" ]; then
        echo -n "Installing missing Dependencies"
        #apt-get --force-yes --yes install $PKGSTOINSTALL
        echo -n "$PKGSTOINSTALL"
    else
        echo -n "busted Something went wrong"
    fi
}

#debianINST
#
checkPrecise()
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
checkSqueeze()
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


