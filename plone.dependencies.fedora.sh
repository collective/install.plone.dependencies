#!/bin/bash
# Inspired by:  http://www.mirkopagliai.it/
# Description:  will check and install Plone [http://plone.org] dependencies
# License:      GPL
# Version:      0.1.beta
#================================================

yum -y install yum-utils

yum -y groupinstall "Development Tools"

yum -y install wv xpdf libxslt-devel zlib-devel libxml2-devel python-devel python-lxml libgsasl-devel openssl openssl-devel glibc-devel ncurses-devel

# ToDo
# - switch group install development tools, to only packages we need, otherwise we will install too much crap and it will be
# harder to check all packages ...
# - check for already installed packages
# - yum -s according to the wiki [not tested, yet]
# - rewrite header of this script, remove Inspired by, move that to credits
# - some links: http://unix.stackexchange.com/questions/23085/yum-groupinstall-development-libraries
# - http://www.cyberciti.biz/faq/rhel-yum-grouplist-groupinstall-option-not-working/
# - http://thevagabondgeek.com/5-centos-yum-groupinstall-basics
