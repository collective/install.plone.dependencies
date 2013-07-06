.. contents :: :local:


Introduction
--------------

*install.plone.dependencies* is a script with the aim of making the install of dependencies for Plone easier for beginners.

Currently this script is tested with Ubuntu 12.04, 12.10, 13.04,Debian 7 [Wheezy], Centos 6.3 and Centos 6.4

Usage
------

* Download the script::

    wget https://github.com/collective/install.plone.dependencies/archive/master.zip

* Unzip that file::

    unzip master

* Chnage into the directory::

    cd install.plone.dependencies-master

* Make the script executable::

    chmod +x install_dependencies.sh

* Run it::

    ./install_dependencies.sh

* Run it with arguments::

   ./install_dependencies.sh --ubuntu

   ./install_dependencies.sh --debian

   ./install_dependencies.sh --centos

   ./install_dependencies.sh --help
