#!/bin/bash
# Inspired by:  http://www.mirkopagliai.it/
# Description:  will check and install Plone [http://plone.org] dependencies
# License:      GPL
# Version:      0.1.beta
#================================================

# Colors
txtrst=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red

DEPENDENCIES=(build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils)

echo “Welcome to ${txtred} Checking for missing Dependencies .... ${txtrst}!”

# First update the system
apt-get update

# What dependencies are missing?
PKGSTOINSTALL=""
for (( i=0; i<${tLen=${#DEPENDENCIES[@]}}; i++ )); do
    # Debian, Ubuntu and derivatives (with dpkg)
    if which dpkg &> /dev/null; then
        if [[ ! `dpkg -l | grep -w "ii  ${DEPENDENCIES[$i]} "` ]]; then
            PKGSTOINSTALL=$PKGSTOINSTALL" "${DEPENDENCIES[$i]}
        fi
    # If it's impossible to determine if there are missing dependencies, mark all as missing
    else
        PKGSTOINSTALL=$PKGSTOINSTALL" "${DEPENDENCIES[$i]}
    fi
done

# If some dependencies are missing, install them
if [ "$PKGSTOINSTALL" != "" ]; then
    echo -n "Installing missing Dependencies"
    # Debian, Ubuntu and derivatives (with apt-get)
    if which apt-get &> /dev/null; then
        echo -n "$PKGSTOINSTALL"
        #apt-get --force-yes --yes install $PKGSTOINSTALL
    # Else, if no package manager has been founded
    else
        echo "ERROR: Something went wrong. Please, install manually ${DEPENDENCIES[*]}."
    fi
fi


