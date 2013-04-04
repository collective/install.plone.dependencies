#!/bin/bash
# Description:  will check and install Plone [http://plone.org] dependencies
# License:      GPL
# Version:      0.1.beta
#================================================

#yum -y install yum-utils

#yum -y groupinstall "Development Tools"

# if we do not use yum -y groupinstall "Development Tools"
#yum -y install gcc gcc-c++ autoconf automake binutils gettext libtool make pkgconfig strace bison flex gdb patch


#yum -y install wv xpdf libxslt-devel zlib-devel libxml2-devel python-devel python-lxml libgsasl-devel openssl openssl-devel glibc-devel ncurses-devel

from the mlist: [christian.ledermann@gmail.com]
I use;

yum install gcc-c++ patch openssl-devel libjpeg-devel libxslt-devel
readline-devel make which

yum install python-ldap wv xpdf libxslt-devel \
    zlib-devel libxml2-devel python-ldap python-devel \
    python-lxml libgsasl-devel openssl openssl-devel glibc-devel ncurses-devel
to install all necessary dependencies on RH/Centos


checkFEDORA()
{
FEDORARPM='gcc-c++ patch openssl-devel libjpeg-devel libxslt-devel \
readline-devel make which wv xpdf libxslt-devel zlib-devel \
libxml2-devel python-ldap python-devel python-lxml libgsasl-devel \
openssl openssl-devel glibc-devel ncurses-devel'
    for package in $FEDORARPM; do
    RPM_OK=$(rpm -qa $package)
    if [ "" == "$RPM_OK" ]; then
        echo "Installing $package"
        # yum -y install $package
    fi
done
}

checkFEDORA

# ToDo
# - do we want to check/install git ?
# - yum -s according to the wiki [not tested, yet]
# - rewrite header of this script, remove Inspired by, move that to credits
# - some links: http://unix.stackexchange.com/questions/23085/yum-groupinstall-development-libraries
# - http://www.cyberciti.biz/faq/rhel-yum-grouplist-groupinstall-option-not-working/
# - http://thevagabondgeek.com/5-centos-yum-groupinstall-basics
