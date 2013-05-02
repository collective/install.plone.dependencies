#!/bin/sh
# this script is really basic and without any checks, it is meant to be to tun on clean test boxex

HELPDIR='helper_scripts'

#download base script
wget --no-check-certificate https://raw.github.com/collective/install.plone.dependencies/dev/check_dependencies.sh
chmod +x check_dependencies.sh

# prepare helper_scripts
mkdir "$HELPDIR"
cd "$HELPDIR"
wget --no-check-certificate https://raw.github.com/collective/install.plone.dependencies/dev/helper_scripts/check_ubuntu.sh
wget --no-check-certificate https://raw.github.com/collective/install.plone.dependencies/blob/dev/helper_scripts/check_debian.sh
chmod +x check_ubuntu.sh
chmod +x check_debian.sh
