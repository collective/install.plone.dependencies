#!/bin/bash
# Description:  check which OS
# License:      GPL
# Version:      0.1.beta
#================================================

# Check for FreeBSD in the uname output
# If it's not FreeBSD, then we move on!
if [ "$(uname -s)" == 'FreeBSD' ]; then
    OS='freebsd'

# Check for a redhat-release file and see if we can
# tell which Red Hat variant it is
elif [ -f "/etc/redhat-release" ]; then
        RHV=$(egrep -o 'Fedora|CentOS|Red.Hat' /etc/redhat-release)
        case $RHV in
                Fedora) OS='fedora';;
                CentOS) OS='centos';;
                Red.Hat) OS='redhat';;
        esac

# Check for debian_version
#elif [ -f "/etc/debian_version" ]; then
#    OS='debian'

# new for debian and or ubuntu now we use lsb_release
# check if debian or ubuntu
elif [ -f "/etc/debian_version" ]; then
        LSB=$(lsb_release -c | egrep -o 'wheezy|precise')
        case $LSB in
                wheezy) OS='debian';;
                precise) OS='ubuntu';;
        esac

# this could come in handy, because sometimes the names of packages are slightly different
# in debian and ubuntu


# Check for arch-release
elif [ -f "/etc/arch-release" ]; then
    OS='arch'

# Check for SuSE-release
elif [ -f "/etc/SuSE-release" ]; then
    OS='suse'

fi

# echo the result
echo "$OS"

#todo:
# rewrite all to use lsb_release, well where it is possible
