Todo
=====

- split into 'check scripts' per OS like check_debian, check_ubuntu
- make less use of sudo or root, build password prompt into whiptail
- rewrite check_dependencies script
- rewrite whiptail messages to proper messages
- fix centos libxml issue, stece is doingthat with an lxm_static buildout

Example:
--------
.. code::

   #!/bin/bash
   whiptail --title "Sudo Password" --passwordbox "Please enter the password" 8 78 3>&1 1>&2 2>&3
   sudo -S apt-get update
   exit

we should add -k to tell sudo to forget the passwd
