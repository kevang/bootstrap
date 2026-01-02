#!/bin/bash

sleep 1
clear
figlet "Updates"

_isInstalledYay() {
    package="$1";
    check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

if gum confirm "DO YOU WANT TO START THE UPDATE NOW?" ;then
    echo 
    echo ":: Update started."
elif [ $? -eq 130 ]; then
        exit 130
else
    echo
    echo ":: Update canceled."
    exit;
fi

yay

notify-send "Update complete"
echo 
echo ":: Update complete"
sleep 2
