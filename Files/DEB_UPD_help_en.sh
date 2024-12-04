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
    echo "  -h, --help                  Shows this help message."
    echo "  -o, --onlyupdate            Updates only the repositories and shows available updates without upgrading the packages."
    echo "  -n, --no-autoremove         Prevents the automatic removal of unnecessary packages after upgrade."
    echo "  -d, --dist-upgrade          Performs a one-time dist-upgrade."
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
    echo -e $YELLOW $TXTBOLD "How it works:" $NORMAL
    echo -e $TXTBOLD "The script performs the following steps:" $NORMAL
    echo "1. Check for root privileges."
    echo "2. Update the repositories."
    echo "3. Display available updates."
    echo "4. Upgrade the packages."
    echo "5. Automatically remove unnecessary packages (if not disabled)."
    echo "6. Optionally perform rootkit checks."
    echo "7. Logfile management: rotation and deletion of old logfiles."
    echo "8. Send notifications for errors or successful completion (depending on configuration)."
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Usage:" $NORMAL
    echo "To run the script, use the following command:"
    echo "./Debian-Updater.sh [Options]"
    echo
    echo "Example: ./Debian-Updater -n -s (Does not perform autoremove and runs in silent mode)"
    echo -e $BLUE "========================================" $NORMAL
}
