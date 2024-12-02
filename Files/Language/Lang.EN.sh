#!/bin/bash

### TXT Functions and Variables ###
# LF = Language Function
# LV = Language Variable
# LFA = LogFile Output

LV_Update_start="$NORMAL Executing repository update \t \t \t "
LV_Update_done="Update successfully executed"
LV_Update_error="Error with apt-get update -q"
LV_RootCheck="Checking for root privileges"
LV_Show_upgradeable="Show upgradeable packages:"
LV_Install="Update installed packages"
LV_Autoremove="Remove unnecessary packages"
LV_LogKiller="Delete logfile(s)"

LF_ISROOT_Pos() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}

LF_ISROOT_Neg() {
  echo -n -e "$NORMAL[$RED✗$NORMAL] No ROOT privileges! \t \t " 
  echo "Please run the script with ROOT privileges (sudo)"; exit 1;
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

LF_ErrorHandling_Y() {
  log_message -e $NORMAL "The script ran successfully, there were $GREEN no errors $NORMAL, the $GREEN system has been updated! $NORMAL"
}

LF_ErrorHandling_N() {
  log_message -e $NORMAL "There were $RED errors $NORMAL (Error code: $RED $FEHLER $NORMAL)$NORMAL! Please check the logfile at the following path: $YELLOW $LOGFILE"
}

LF_ErrorHandling_RKH() {
  log_message -e $GREEN "RKHUNTER $NORMAL was also $GREEN updated $NORMAL and a $GREEN property update was executed! $NORMAL"
}

LF_Logline() {
  echo "=== NEW SCRIPT RUN ===" >>$LOGFILE
}

LF_TimeOutput() {
  log_message -e $NORMAL "The update took $YELLOW $((runtime / 60)) minutes $NORMAL and $YELLOW $((runtime % 60)) seconds $NORMAL."
}

LF_TimeOutput_Logfile() {
  echo "The update took $((runtime / 60)) minutes and $((runtime % 60)) seconds." >>$LOGFILE
}

LF_LogRotationMaxAge() {
  log_message -e "Old logfiles (older than $max_log_age days) deleted \t $NORMAL[$GREEN✓$NORMAL]"
}

# Logfile Outputs

LFA_Upgrade_Y="Upgrade successfully executed"
LFA_Upgrade_N="Error with apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove successfully executed"
LFA_Autoremove_N="Error with apt-get autoremove -y -q"
LFA_Notification_Option_notSet="No external notification option enabled"
LFA_LOGROTATION_Err_1="--No logfile for rotation--"
LFA_NOOLDLOGS="No logfiles older than $LOGFILE_MAX_AGE days found \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Checking for RKHunter"
LV_RKHunterFound="RKHunter found on the system"
LV_RKHunterUpd="Updating RKHunter and property update"
LV_RKHunterUpd_log="RKHunter update and propupd executed"
LV_RKHunterCheckInfo="Rootkit check may take some time"
LV_RKHunterCheck="RKHunter check for rootkits"

##### Nextcloud ####
LV_NC_APPS="Update all Nextcloud apps"

##### MediaWiki ####
LV_MW="Update MediaWiki"
