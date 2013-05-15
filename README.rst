.. contents :: :local:


Introduction
------------

*install.plone.dependencies* is a script with the aim of making the install of dependencies for Plone easier for beginners.

<<<<<<< HEAD
Currently this script is tested with Ubuntu 12.04. Support for more Operating Systems may come or not ...


Requirements
------------
You need root access or sudo

=======
Currently this script is tested with Ubuntu 12.04, 12.10, 13.04,Debian 7 [Wheezy] and Centos 6.3
>>>>>>> dev

Usage
------

* Download the script::

    wget https://raw.github.com/collective/install.plone.dependencies/master/install_dependencies.sh

* Make is executable::

    chmod +x install_dependencies.sh

* Run it::

    ./install_dependencies.sh
<<<<<<< HEAD

* Run it with arguments::

   ./install_dependencies.sh --ubuntu

=======

* Run it with arguments::

   ./install_dependencies.sh --ubuntu

   ./install_dependencies.sh --squezze

   ./install_dependencies.sh --centos

   ./install_dependencies.sh --help
>>>>>>> dev
