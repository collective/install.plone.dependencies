#!/usr/bin/env bash
# Description:  check for OS and apply dependecies script
# License:      GPL
# Version:      0.1
#================================================
LOGFILE="install.log"

# Those are the messages for whiptail
. helper_scripts/whiptail_messages.sh

# First our error_exit
error_exit()
{
    echo "$1" 1>&2
    exit 1
}

# We want the redirect everything to a file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1> $LOGFILE 2>&1

README() {
    README_MSG
    readmestatus=$?
    if [ $readmestatus = 1 ]; then
        README_GOODBYE
        error_exit
    else
        :
    fi
}

CHECK_OS()
{
if [ -f "/etc/debian_version" ]; then
    LSB=$(lsb_release -c | egrep -o 'wheezy|jessie|precise|quantal|raring|lucid')
    case $LSB in
        wheezy) OS='wheezy';;
        jessie) OS='jessie';;
        precise) OS='precise';;
        quantal) OS='quantal';;
        raring)  OS='raring';;
        lucid)   OS='lucid';;
    esac

elif [ -f "/etc/redhat-release" ]; then
    RHV=$(egrep -o 'Fedora|CentOS|Red.Hat' /etc/redhat-release)
    case $RHV in
        Fedora) OS='fedora';;
        CentOS) OS='centos';;
        Red.Hat) OS='redhat';;

    esac

fi


if [ "$OS" == 'wheezy' ]; then
    . helper_scripts/wget_debian.sh
elif [ "$OS" == 'jessie' ]; then
    . helper_scripts/wget_debian.sh
elif [ "$OS" == 'precise' ]; then
    . helper_scripts/check_precise.sh
elif [ "$OS" == 'quantal' ]; then
    . helper_scripts/check_quantal.sh
elif [ "$OS" == 'raring' ]; then
    . helper_scripts/check_raring.sh
elif [ "$OS" == 'lucid' ]; then
    . helper_scripts/check_lucid.sh
elif [ "$OS" == 'centos' ]; then
    . helper_scripts/check_centos.sh

else
    OS_NOT_FOUND
    error_exit
fi
}
# Run the script with arguments or not for example:
# install_dependencies.sh --ubuntu
# use that only if you now what are you doing
case "$1" in
    "--wheezy")
        CHECK_OS
        GOODBYE
    ;;

    "--jessie")
        Check_OS
        GOODBYE
    ;;

    "--precise")
        Check_OS
        GOODBYE
    ;;

    "--quantal")
        Check_OS
        GOODBYE
    ;;

    "--raring")
        Check_OS
        GOODBYE
    ;;

    "--lucid")
        Check_OS
        GOODBYE
    ;;

    "--centos")
        CHECK_OS
    ;;

    "--help")
        HELP
    ;;

    "")
        README
        CHECK_OS
        GOODBYE
    ;;
esac

