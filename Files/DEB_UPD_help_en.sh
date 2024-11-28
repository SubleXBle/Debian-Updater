#!/bin/bash

F_HELP() {
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Help for Debian-Updater Script" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e $BLUE "Script by SubleXBle (https://github.com/SubleXBle)" $NORMAL
    echo
    echo -e $TXTBOLD "This script manages system updates and notifications." $NORMAL
    echo
    echo -e $YELLOW $TXTBOLD "Available options:" $NORMAL
    echo "  -s, --silent                Run the script in silent mode without displaying output on the console."
    echo "  -h, --help                  Displays this help information."
    echo "  -o, --onlyupdate            Updates only the repositories and shows available updates without upgrading the packages."
    echo "  -n, --no-autoremove         Prevents the automatic removal of no longer needed packages after the upgrade."
    echo "  -d, --dist-upgrade          Run the scripz with --dist-upgrade instead of upgrade"
    echo
    echo -e $BLUE "========================================"
    echo -e $YELLOW $TXTBOLD "User Variables (in DEB_UPD_config.sh):" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e "$TXTBOLD Settings in DEB_UPD_config.sh" $NORMAL
    echo -e "Logfiles"
    echo -e "Log rotation"
    echo -e "Notifications"
    echo -e "RK-Hunter"
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Functionality:" $NORMAL
    echo -e $TXTBOLD "The script performs the following steps:" $NORMAL
    echo "1. Checks for root privileges."
    echo "2. Updates the repositories."
    echo "3. Shows available updates."
    echo "4. Upgrades the packages."
    echo "5. Automatically removes packages that are no longer needed (if not disabled)."
    echo "6. Optionally performs rootkit checks."
    echo "7. Logfile management: rotation and deletion of old log files."
    echo "8. Sends notifications in case of errors or successful completion (depending on configuration)."
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Usage:" $NORMAL
    echo "To run the script, use the following commands:"
    echo "./Debian-Updater.sh [options]"
    echo
    echo "e.g.: ./Debian-Updater -n -s (Runs without autoremove and in silent mode)"
    echo -e $BLUE "========================================" $NORMAL
}
