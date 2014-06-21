#!/bin/sh
# Wrapper for whiptail/dialog/bash-console to display the interface on console

WHIPTAIL () {
    height=20
    width=78
    dtype=error
    scrolltext=""
    title=""
    for option; do
        optarg=`expr "x$option" : 'x[^=]*=\(.*\)'`
        case $option in
            --height=*)
                height=$optarg
                ;;
            --width=*)
                width=$optarg
                ;;
            --yesno | --msgbox | --inputbox | --passwordbox )
                dtype=$option
                ;;
            --title=* )
                title=$optarg
                ;;
            --scrolltext )
                scrolltext=$option
                ;;
            *)
                prompt=$option
                ;;
        esac
    done


    if [ "X$whipdialog" == "X" ]; then
        whipdialog=`which dialog || which whiptail`
    	if [ $? -gt 0 ]; then
    	    whipdialog="bashme"
    	fi
    fi
    if [ "X$whipdialog" == "Xdialog" ]; then
        scrolltext=""
    fi

    if [ $whipdialog == "bashme" ]; then
        echo "$title"
        echo
        case "$dtype" in
            --yesno)
                echo "$prompt"
                echo
                select answer in "Yes" "No"; do
                    case $answer in
                        "Yes")
                            [ 0 -eq 0 ]
                            return "$?"
                            ;;
                        "No")
                            [ 1 -eq 0 ]
                            return "$?"
                            ;;
                    esac
                done
                ;;
            --msgbox)
                echo "$prompt"
                echo
                read -p "Press any key: " -n 1
                echo
                ;;
            --inputbox | --passwordbox)
                read -e -p "$prompt" WHIPTAIL_RESULT
                ;;
            *)
                echo "Unknown dialog type"
                exit 1
        esac
    else
        WHIPTAIL_RESULT=$($whipdialog --title "$title" $dtype "$prompt" $height $width 3>&1 1>&2 2>&3)
    fi
    return $?
}

README_MSG() {
    WHIPTAIL --title="Welcome" --yesno \
"This script will check for dependencies and if needed, install them.

Depending on your OS you will need root or sudo permissions.

For more information and options, re-run this script with --help

Do you want to continue?"
}

README_GOODBYE() {
    WHIPTAIL --title="Goodbye" --msgbox \
    "If you choose to install the requirements manually, see http://developer.plone.org"
}

GOODBYE() {
    WHIPTAIL --title "Dependencies installed" --msgbox \
"All missing dependencies have been installed.

Now, you're ready to install Plone itself.
For more support or information, please visit: https://plone.org/support"
}


HELP() {
    WHIPTAIL --title="Usage" --msgbox --scrolltext \
"""This script will try to detect your OS, and will try to install all missing dependencies for Plone
using the package manager for your OS.

Depending on your OS this scripts needs sudo or root permissions.
If you don't know what sudo is, please read
https://en.wikipedia.org/wiki/Sudo

More information: http://docs.plone.org
Help and support: http://plone.org/support

There are also some options available:
./install_dependencies.sh --lucid
./install_dependencies.sh --jessie
./install_dependencies.sh --centos

These options will skip OS detection and will go straight to checking and installing dependencies"""
}

OS_NOT_FOUND() {
    os=`uname -s -r`
    WHIPTAIL --title="Error" --msgbox """
Sorry, $os is not yet supported.

Information on Plone dependencies: http://docs.plone.org/manage/installing/requirements.html
General help and support: http://plone.org/support
"""
}

ASK_INSTALL_MISSING () {
    WHIPTAIL --title="Missing packages" --yesno \
"These are the packages that need to be installed :\n${MISSING_DEP// /\\n} \n
Want to install ? "
}

ASK_INSTALL_MISSING_CENTOS () {
    WHIPTAIL --title="Missing packages" --yesno --scrolltext \
"These are the packages that need to be installed :\n${MISSING_CENTOSRPM// /\\n} \n
Want to install ? "
}


NO_INSTALL_WARNING () {
    WHIPTAIL --title="Cancel" --msgbox  \
"You decided not to install missing dependencies via this script.

You can re-run this script, or install them manually."
}

# Info message, we use whiptail for that
CENTOS_SUCCESS() {
  WHIPTAIL --title="Dependencies installed" --msgbox "All missing dependencies have been installed.

Now, you are ready to install Plone itself.

Since you are using CentOS, please make sure to run the installer with --static-lxml

For support and more information, please visit: https://plone.org/support"
}
