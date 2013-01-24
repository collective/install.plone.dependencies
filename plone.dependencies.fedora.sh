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
# check for already installed packages
# yum -s according to the wiki [not tested, yet]
