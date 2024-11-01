#!/bin/bash

### TXT Functions and Variables ###
# LF = Language Function
# LV = Language Variable
# LFA = LogFile Output

LV_Update_start="$NORMAL Running update for repositories \t \t "
LV_Update_done="Update completed successfully"
LV_Update_error="Error with apt-get update -q"
LV_RootCheck="Checking for root privileges"
LV_Show_upgradeable="Display packages:"
LV_Install="Updating installed packages \t "
LV_Autoremove="Removing no longer needed packages"
LV_LogKiller="Deleting logfile(s)"

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
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}
# Output Update / Upgrade / Autoremove - Negative
LF_Negative_Output_Check() {
  log_message -n -e "$NORMAL[$RED✗$NORMAL] \t \t " | tee -a $LOGFILE
  log_message -e "$NORMAL Error code: $RED $? $NORMAL" | tee -a $LOGFILE
}

LF_Fehlerbehandlung_Y() {
	log_message -e $NORMAL "The script completed without errors; $GREEN no errors $NORMAL occurred, and the $GREEN system has been updated! $NORMAL"
}

LF_Fehlerbehandlung_N() {
	log_message -e $NORMAL "$RED Errors $NORMAL(error code: $RED $FEHLER $NORMAL)$NORMAL occurred! Please check the log file at the following path: $YELLOW $LOGFILE"
}

LF_Fehlerbehandlung_RKH() {
	log_message -e $GREEN "RKHUNTER $NORMAL was also $GREEN updated $NORMAL, and a $GREEN property update was performed! $NORMAL"
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
	log_message -e "Deleted old log files (older than $max_log_age days) \t $NORMAL[$GREEN✓$NORMAL]"
}

# Logfile Outputs

LFA_Upgrade_Y="Upgrade completed successfully"
LFA_Upgrade_N="Error with apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove completed successfully"
LFA_Autoremove_N="Error with apt-get autoremove -y -q"
LFA_Notification_Option_notSet="No external notification option enabled"
LFA_LOGROTATION_Err_1="--No logfile for rotation--"
LFA_NOOLDLOGS="No log files older than $LOGFILE_MAX_AGE days found \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Checking for RKHunter"
LV_RKHunterFound="RKHunter found on system"
LV_RKHunterUpd="Updating RKHunter and performing property update"
LV_RKHunterUpd_log="RK-Hunter update and propupd completed"
LV_RKHunterCheckInfo="Rootkit check may take some time"
LV_RKHunterCheck="RKHunter checking for rootkits"
