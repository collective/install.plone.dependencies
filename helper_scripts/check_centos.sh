#!/usr/bin/env bash
# Description:  check Centos [6.3/6.4] for Plone dependencies
# License:      GPL
# Version:      0.1
#================================================


# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

install_CentOS()
{
    CENTOSRPM='gcc-c++ patch openssl-devel libjpeg-devel libxslt-devel readline-devel make which wv xpdf libxslt-devel zlib-devel'

    MISSING_CENTOSRPM=''

    for package in $CENTOSRPM; do
    RPM_OK=$(rpm -qa $package)
    if [ "" == "$RPM_OK" ]; then
        MISSING_CENTOSRPM=$MISSING_CENTOSRPM' '$package
        #echo "Installing $package"
    fi
done

if [ -n "$MISSING_CENTOSRPM" ]; then
    whiptail --title "Info" --yesno --scrolltext "These are packages that need to be installed :\n${MISSING_CENTOSRPM// /\n} \n
    Want to install ? " 20 78
        givestatus=$?
        if [ $givestatus = 0 ]; then
            echo "installing $MISSING_CENTOSRPM"
            #su -c 'yum -y install '$MISSING_CENTOSRPM'
        else
            whiptail --title "Cancel" --msgbox "You decided not to install missing dependecies" 8 78
            error_exit
        fi
fi

}

install_CentOS





