#!/usr/bin/env bash

LOGFILE="dryrun.log"


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

DRY_OS()
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
    . helper_scripts/dry_ubuntu.sh
elif [ "$OS" == 'debian' ]; then
    . helper_scripts/dry_debian.sh
elif [ "$OS" == 'centos' ]; then
    . helper_scripts/dry_centos.sh

else
    error_exit
fi
}

