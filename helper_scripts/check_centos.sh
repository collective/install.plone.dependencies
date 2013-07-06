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
    CENTOSRPM='gcc-c++ patch openssl-devel libjpeg-devel libxslt-devel
    readline-devel make which wv xpdf libxslt-devel zlib-devel'

    MISSING_CENTOSRPM=''

    for package in $CENTOSRPM; do
    RPM_OK=$(rpm -qa $package)
    if [ "" == "$RPM_OK" ]; then
        MISSING_CENTOSRPM=$MISSING_CENTOSRPM' '$package
        #echo "Installing $package"
    fi
done

if [ -n "$MISSING_CENTOSRPM" ]; then
    WHIPTAIL --title "Info" --yesno --scrolltext "These are packages that need to be installed :\n${MISSING_CENTOSRPM// /\n} \n
    Want to install ? " 20 78
        givestatus=$?
        if [ $givestatus = 0 ]; then
            echo "installing $MISSING_CENTOSRPM"
            #su -c 'yum -y install '$MISSING_CENTOSRPM' 2>&4
        else
            WHIPTAIL --title "Cancel" --msgbox "You decided not to install missing dependecies, you can always run this script again" 8 78
            error_exit
        fi
fi

}

# Info message, we use whipetail for that
CENTOSMSG() {
  WHIPTAIL --title "Check Dependencies" --msgbox "All missing dependencies have been installed.\n
Now, You are ready to install Plone itself.\n\n\n
Since you are using CentOS, please make sure to run the installer with --static-lxml\n\n\n
For support and more information, please visit: https://plone.org/support" 20 78
}



install_CentOS
CENTOSMSG




