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
    LSB=$(lsb_release -c | egrep -o 'wheezy|jessie|precise|quantal|raring')
    case $LSB in
        wheezy) OS='debian';;
        jessie) OS='debian';;
        precise) OS='ubuntu';;
        quantal) OS='ubuntu';;
        raring)  OS='ubuntu';;
    esac

elif [ -f "/etc/redhat-release" ]; then
    RHV=$(egrep -o 'Fedora|CentOS|Red.Hat' /etc/redhat-release)
    case $RHV in
        Fedora) OS='fedora';;
        CentOS) OS='centos';;
        Red.Hat) OS='redhat';;

    esac

fi


if [ "$OS" == 'ubuntu' ]; then
    . helper_scripts/check_ubuntu.sh
elif [ "$OS" == 'debian' ]; then
    . helper_scripts/check_debian.sh
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
    "--ubuntu")
        CHECK_OS
        GOODBYE
    ;;

    "--debian")
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

