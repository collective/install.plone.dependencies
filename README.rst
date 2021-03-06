.. contents :: :local:


Introduction
--------------

*install.plone.dependencies* is a script with the aim of making the install of dependencies for Plone easier for beginners.

Currently this script is tested with Ubuntu 12.04, 12.10, 13.04 and Debian 7 [Wheezy]

Support for Debian 8 [Jessie], Debian 9 [Stretch], Centos 6.3 and Centos 6.4 is included but at
the moment considered to be experimental.

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

   ./install_dependencies.sh --wheezy

   ./install_dependencies.sh --jessie

   ./install_dependencies.sh --stretch

   ./install_dependencies.sh --raring

   ./install_dependencies.sh --precise

   ./install_dependencies.sh --quantal

   ./install_dependencies.sh --lucid

   ./install_dependencies.sh --centos

   ./install_dependencies.sh --help
