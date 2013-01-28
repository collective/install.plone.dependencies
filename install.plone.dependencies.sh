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
checkDEBIAN()
{
    DEPS='build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging wv poppler-utils'
    for package in $DEPS; do
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package | grep "install ok installed")
    #dpkg-query -l $package
    echo Checking for $package: $PKG_OK
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $package"
        #sudo apt-get --force-yes --yes install the.package.name
    fi
done


}

checkDEBIAN

#todo:
#function for fedora
#check os on top of script
#cleanup the debian/ubuntu mess
#split debian and ubuntu, for this we have to tweak the check os script/function
#add centos
# # What dependencies are missing?
# PKGSTOINSTALL=""
# for (( i=0; i<${tLen=${#DEPENDENCIES[@]}}; i++ )); do
#     # Debian, Ubuntu and derivatives (with dpkg)
#     if which dpkg &> /dev/null; then
#         if [[ ! `dpkg -l | grep -w "ii  ${DEPENDENCIES[$i]} "` ]]; then
#             PKGSTOINSTALL=$PKGSTOINSTALL" "${DEPENDENCIES[$i]}
#         fi
#     # If it's impossible to determine if there are missing dependencies, mark all as missing
#     else
#         PKGSTOINSTALL=$PKGSTOINSTALL" "${DEPENDENCIES[$i]}
#     fi
# done

# # If some dependencies are missing, install them
# if [ "$PKGSTOINSTALL" != "" ]; then
#     echo -n "Installing missing Dependencies"
#     # Debian, Ubuntu and derivatives (with apt-get)
#     if which apt-get &> /dev/null; then
#         echo -n "$PKGSTOINSTALL"
#         #apt-get --force-yes --yes install $PKGSTOINSTALL
#     # Else, if no package manager has been founded
#     else
#         echo "ERROR: Something went wrong. Please, install manually ${DEPENDENCIES[*]}."
#     fi
# fi


