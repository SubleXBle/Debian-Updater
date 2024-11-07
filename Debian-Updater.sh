#!/bin/bash

# Debian-Updater.sh by SubleXBle (https://github.com/SubleXBle/Debian-Updater) !Update with ease and how YOU like it!

### User-Config (DEB_UPD_config.sh) ###
source DEB_UPD_config.sh

# Language File
source Files/Language/Lang.$UV_LNG.sh

# get Start Time
start=$(date +%s)

# write Starttime and Date to Logfile
F_Startzeit() {
    echo "$(date +"%d.%m.%Y %H:%M:%S")">>$LOGFILE
}

# Check if Path to Logfile exists
source Files/LogFileCheck.sh

# Change Directory to the Directory where the Script is placed
cd "$(dirname "$0")"

### SCRIPT VARS ###                              
V_ScriptVersion="0.7"
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'
TXTBOLD="\e[1m"
FEHLER=0
SILENT=false
ONLYUPDATE=false
NOAUTOREMOVE=false
STANDARD='-qq'
AUTOCONF='-o Dpkg::Options::="--force-confdef'  #Experimental

## Autoconfig (dpkg) descition
if [ "$UV_AutoStdConf" = true ]; then
    AutoSolve=$AUTOCONF
else
    Autosolve=$STANDARD
fi

### User-Config (DEB_UPD_config.sh) ###
source DEB_UPD_config.sh

### load Notification-Config if needed ###
# Pushover
[ "$UV_PUSHOVER" = true ] && source NotificationConfiguration/PUSHOVER_config.sh
[ "$UV_TELEGRAM" = true ] && source NotificationConfiguration/TELEGRAM_config.sh
[ "$UV_GOTIFY" = true ] && source NotificationConfiguration/GOTIFY_config.sh
[ "$UV_DISCORD" = true ] && source NotificationConfiguration/DISCORD_config.sh
[ "$UV_EMAIL" = true ] && source NotificationConfiguration/EMAIL_config.sh
[ "$UV_TEAMS" = true ] && source NotificationConfiguration/TEAMS_config.sh

### SWITCHES ###

# Silent Switch
log_message() {
    if [ "$SILENT" = false ]; then
        echo -e "$@"
    fi
}

for arg in "$@"; do
    case $arg in
        -s|--silent)
            SILENT=true
            shift
            ;;
        *)
            #
            ;;
    esac
done

# Help Switch
if [[ $1 == "-h" || $1 == "--help" ]]; then
    if [ "$UV_LNG" = DE ]; then
        source Files/DEB_UPD_help.sh
    fi
    if [ "$UV_LNG" = EN ]; then
        source Files/DEB_UPD_help_en.sh
    fi
    if [ "$UV_LNG" = SP ]; then
        source Files/DEB_UPD_help_sp.sh
    fi
    F_HELP
    exit 0
fi

# only Update Switch
if [[ $1 == "-o" || $1 == "--onlyupdate" ]]; then
    ONLYUPDATE=true
fi

# No Autoremove Switch
if [[ $1 == "-n" || $1 == "--no-autoremove" ]]; then
    NOAUTOREMOVE=true
fi

# License Switch
if [[ $1 == "-l" || $1 == "--license" ]]; then
    cat LICENSE
    exit 0
fi

### FUNCTIONS ###

# Check for Root
F_ISROOT() {
    log_message -n -e $NORMAL "$LV_RootCheck \t \t \t "
    if [ "$EUID" -ne 0 ]; then
        LF_ISROOT_Neg
    else
#        log_message -e "$GREEN Root erkannt! \t "
        LF_ISROOT_Pos
    fi
}

# Show OS-Version
F_VERSION_ANZEIGEN() {
        VERSIONSGREP=$(cat /etc/*release | grep PRETTY_NAME | cut -c 13-)
        log_message -n -e $YELLOW "DEBIAN VERSION \t \t "
        log_message -n -e $YELLOW $VERSIONSGREP
}

# update Repositorys
F_UPDATE() {
    log_message -n "$NORMAL $LV_Update_start" | tee -a $LOGFILE
    if apt-get update -qq >>$LOGFILE 2>&1; then
        LF_Positive_Output_Check
        echo "$LV_Update_done">>$LOGFILE
        if [ "$ONLYUPDATE" = true ]; then
            F_ZEITAUSGABE
            exit;
        fi
    else
        FEHLER=RepoUpdateError
        LF_Negative_Output_Check
        echo "$LV_Update_error">>$LOGFILE
    fi
}

# Show Upgradeable
F_ANZEIGE() {
    log_message "$NORMAL $LV_Show_upgradeable"
    if [ "$SILENT" = false ]; then
        if apt list --upgradeable 2>&1; then
            echo "Pakete wurden angezeigt" >>$LOGFILE
        else
            FEHLER=ShowUpgradeableError
            LF_Negative_Output_Check
            echo "Fehler bei apt list --upgradeable">>$LOGFILE
        fi
    fi
}

# Upgrade
F_UPGRADE() {
    log_message -n "$LV_Install \t \t "
    if apt-get upgrade -y $AutoSolve >>$LOGFILE 2>&1; then
        LF_Positive_Output_Check
        echo "$LFA_Upgrade_Y">>$LOGFILE
    else
        FEHLER=UpgradeError
        LF_Negative_Output_Check
        echo "$LFA_Upgrade_N">>$LOGFILE
    fi
}

# Autoremove
F_AUTOREMOVE() {
    if [ "$NOAUTOREMOVE" = false ]; then
        log_message -n "$NORMAL $LV_Autoremove \t \t "
        if apt-get autoremove --purge -y -qq >>$LOGFILE 2>&1; then
            LF_Positive_Output_Check
            echo "$LFA_Autoremove_Y">>$LOGFILE
        else
            FEHLER=AutoremoveError
            LF_Negative_Output_Check
            echo "LFA_Autoremove_N">>$LOGFILE
        fi
    fi
}

[ "$UV_RKHUNTER" = true ] && source Files/RK_Hunter.sh

# Write Logfile to VAR
# Needed to send Logfile via Notification.
F_LOG_TO_VAR() {
    if [[ "$UV_PUSHOVER" == true || "$UV_TELEGRAM" == true || "$UV_GOTIFY" == true || "$UV_DISCORD" == true || "$UV_EMAIL" == true || "$UV_TEAMS" == true ]] && [ "$UV_LOG2MSG" = true ]; then
        BENACHRICHTIGUNG=$(cat "$LOGFILE")
        #if [ "$UV_NotifyOrLog" = true ];
            # Überlege gerade wie ich das am blödesten mache
        #fi
    fi
}

# Delete Logfile(s)
F_LOGKILL() {
    log_message -n "$NORMAL $LV_LogKiller \t \t \t \t "
    if [ "$UV_KEEP_LOG" = false ]; then
        rm -f $LOGFILE
        if [ "$KILL_OLD_LOGS" = true ];then
            rm -f $LOGFILE.*
            rm -f $LOGFILE-*
        fi
        LF_Positive_Output_Check
    else
        LF_Negative_Output_Check
    fi
}

# Output to show possible Errors or No-Error-Run
F_Fehlerbehandlung() {
    echo -e $NORMAL
    if [ "$FEHLER" -eq 0 ]; then
        LF_Fehlerbehandlung_Y
        if [ "$V_ROOTKIT" = true ]; then
            LF_Fehlerbehandlung_RKH
        fi
    else
        LF_Fehlerbehandlung_N
    fi
}

# Logline - shows a new Script-Run in the Logfile
F_LOGLINE() {
    echo -e $NORMAL" ">>$LOGFILE
    echo "=== NEUER SCRIPTLAUF ===">>$LOGFILE
    echo -e $NORMAL" ">>$LOGFILE
    if [ "$SILENT" = true ]; then
        echo "SILENT-Mode=$SILENT">>$LOGFILE
    fi
}

### NOTIFICATIONS ###
### Only load Notification Functions when needed ###

if [[ "$UV_PUSHOVER" == false && "$UV_TELEGRAM" == false && "$UV_GOTIFY" == false && "$UV_EMAIL" == false && "$UV_DISCORD" == false && "$UV_TEAMS" == false ]]; then
    echo "LFA_Notification_Option_notSet">>$LOGFILE
    V_NOTIFY=false
else
    source Files/NOTIFICATION_FUNCTIONS.sh
    V_NOTIFY=true
fi

### TIME MANAGEMENT ###

# to show the Script-Runtime
F_ZEITAUSGABE() {
end=$(date +%s)    # Endzeit erfassen
runtime=$((end - start)) # Laufzeit berechnen
log_message -e $NORMAL
if [ "$UV_KEEP_LOG" = false ]; then
    LF_Zeitausgabe
else
    LF_Zeitausgabe>>$LOGFILE
fi
}

# show script-runtime in Logfile
F_ZEIT_IN_LOG() {
end=$(date +%s)
runtime=$((end - start))
LF_Zeitausgabe_Logfile
}

### LOGROTATION ###
# Logrotation - controlled by Variables (DEB_UPD_config.sh)
F_LOG_ROTATE() {
    log_message -n -e $NORMAL "--Logfile-Rotation-- \t \t \t \t "
    local max_log_age=$LOGFILE_MAX_AGE  # Maximale Anzahl von Tagen, nach denen alte Logfiles gelöscht werden
    
    # Check if Logfile exists
    if [ -f "$LOGFILE" ]; then
        mv "$LOGFILE" "$LOGFILE-$(date +"%Y%m%d-%H%M%S").log"
        LF_Positive_Output_Check
    else
        log_message -e "$NORMAL[$YELLOW!$NORMAL] $LFA_LOGROTATION_Err_1"
    fi

    # Delete Logfile when X Days old (DEB_UPD_config.sh)
    OldLogs=$(find "$(dirname "$LOGFILE")" -name "$(basename "$LOGFILE")-*" -type f -mtime +$max_log_age)
    if [[ -n "$OldLogs" ]]; then
        find "$(dirname "$LOGFILE")" -name "$(basename "$LOGFILE")-*" -type f -mtime +$max_log_age -exec rm {} \;
        LF_LogRotationMaxAge
    else
        log_message -e "$LFA_NOOLDLOGS"
    fi
}

### TXT Functions and Variables for a nicer Scriptrun ###
# Start-Message
T_StartMSG() {
    T_LEERZEILE
    log_message -e $BLUE $TXTBOLD "Debian-Updater Version: $V_ScriptVersion" $NORMAL
    log_message -e $BLUE $TXTBOLD "Check Help (-h / --help) for Options" $NORMAL
    T_LEERZEILE
}
# Blank Line
T_LEERZEILE() {
    log_message -e $NORMAL
}

### SCRIPTAUFRUF ###

F_LOGLINE
F_Startzeit
T_StartMSG
F_VERSION_ANZEIGEN
T_LEERZEILE
T_LEERZEILE
F_ISROOT
F_UPDATE
F_ANZEIGE
F_UPGRADE
F_AUTOREMOVE
[ "$UV_RKHUNTER" = true ] && F_ROOTKIT
F_ZEIT_IN_LOG
if [[ "$V_NOTIFY" = true && "$UV_NotifyOnlyOnError" = false ]]; then
    F_LOG_TO_VAR
    F_PUSHOVER
    F_TELEGRAM
    send_gotify_message
    F_DISCORD
    F_EMAIL
    F_TEAMS
else
    if [[ "$FEHLER" > 0 && "$UV_NotifyOnlyOnError" = true ]]; then
        F_LOG_TO_VAR
        F_PUSHOVER
        F_TELEGRAM
        send_gotify_message
        F_DISCORD
        F_EMAIL
        F_TEAMS
    fi
    #    
fi
if [ "$UV_KEEP_LOG" = false ]; then
    F_LOGKILL
else
    F_LOG_ROTATE       
fi
F_Fehlerbehandlung
F_ZEITAUSGABE
T_LEERZEILE