#!/bin/bash

### TXT Functions and Variables ###
# LF = Language Function
# LV = Language Variable
# LFA = LogFile Output

LV_Update_start="$NORMAL Running repository update \t \t \t "
LV_Update_done="Update completed successfully"
LV_Update_error="Error during apt-get update -q"
LV_RootCheck="Checking for root privileges"
LV_Show_upgradeable="Showing packages:"
LV_Install="Updating installed packages"
LV_Autoremove="Removing unused packages"
LV_LogKiller="Deleting logfile(s)"
LV_NotificationNotSent="ERROR: Could not send notification!"
LV_NotificationSent="Notification was successfully sent"
LV_SendMessage="Sending notification"

LF_ISROOT_Pos() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}

LF_ISROOT_Neg() {
  echo -n -e "$NORMAL[$RED✗$NORMAL] No ROOT privileges! \t \t " 
  echo "Please run script with ROOT privileges (sudo)"; exit 1;
}

# Output Update / Upgrade / Autoremove - Positive
LF_Positive_Output_Check() {
  log_message -n -e $"$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}
# Output Update / Upgrade / Autoremove - Negative
LF_Negative_Output_Check() {
  log_message -n -e "$NORMAL[$RED✗$NORMAL] \t \t " | tee -a $LOGFILE
  log_message -e "$NORMAL Error code: $RED $? $NORMAL" | tee -a $LOGFILE
}

LF_Fehlerbehandlung_Y() {
	log_message -e $NORMAL "The script has completed, $GREEN no errors $NORMAL occurred, and the $GREEN system was updated! $NORMAL"
}

LF_Fehlerbehandlung_N() {
	log_message -e $NORMAL "There were $RED errors $NORMAL(Error code: $RED $FEHLER $NORMAL)$NORMAL! Please check the logfile at the following path:$YELLOW $LOGFILE"
}

LF_Fehlerbehandlung_RKH() {
	log_message -e $GREEN "RKHUNTER $NORMAL has also been $GREEN updated $NORMAL and a $GREEN property update has been performed! $NORMAL"
}

LF_Logline() {
	echo "=== NEW SCRIPT RUN ===">>$LOGFILE
}

LF_Zeitausgabe() {
	log_message -e $NORMAL "The update took $YELLOW $((runtime / 60)) minutes $NORMAL and $YELLOW $((runtime % 60)) seconds $NORMAL."
}

LF_Zeitausgabe_Logfile() {
	echo "The update took $((runtime / 60)) minutes and $((runtime % 60)) seconds.">>$LOGFILE
}

LF_LogRotationMaxAge() {
	log_message -e "Old logfiles (older than $max_log_age days) deleted \t $NORMAL[$GREEN✓$NORMAL]"
}

# Logfile Outputs

LFA_Upgrade_Y="Upgrade completed successfully"
LFA_Upgrade_N="Error during apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove completed successfully"
LFA_Autoremove_N="Error during apt-get autoremove -y -q"
LFA_Notification_Option_notSet="No external notification option enabled"
LFA_LOGROTATION_Err_1="--No logfile for rotation--"
LFA_NOOLDLOGS="No logfiles older than $LOGFILE_MAX_AGE days found \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Checking for RKHunter"
LV_RKHunterFound="RKHunter found on system"
LV_RKHunterUpd="Updating RKHunter and property update"
LV_RKHunterUpd_log="RK-Hunter update and propupd performed"
LV_RKHunterCheckInfo="Rootkit check may take some time"
LV_RKHunterCheck="RKHunter checking for rootkits"

##### Nextcloud ####
LV_NC_APPS="Updating all Nextcloud apps"

##### MediaWiki ####
LV_MW="Updating MediaWiki"
