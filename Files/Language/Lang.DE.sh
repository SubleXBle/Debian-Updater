#!/bin/bash

### TXT Funktionen und Variablen ###
# LF = Language Function
# LV = Language Variable
# LFA = LogFile Ausgabe


LV_Update_start="$NORMAL Update der Repos ausführen \t \t \t "
LV_Update_done="Update erfolgreich ausgeführt"
LV_Update_error="Fehler bei apt-get update -q"
LV_RootCheck="Prüfung auf Root Rechte"
LV_Show_upgradeable="Pakete anzeigen:"
LV_Install="Installierte Pakete aktualisieren"
LV_Autoremove="Nicht mehr benötigte Pakete entfernen"
LV_LogKiller="Logfile(s) löschen"




LF_ISROOT_Pos() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}

LF_ISROOT_Neg() {
  echo -n -e "$NORMAL[$RED✗$NORMAL] Keine ROOT-Rechte! \t \t " 
  echo "Script bitte mit ROOT-Rechten ausführen (sudo)"; exit 1;
}

# Output Update / Upgrade / Autoremove - Positive
LF_Positive_Output_Check() {
  log_message -n -e $"$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}
# Output Update / Upgrade / Autoremove - Negative
LF_Negative_Output_Check() {
  log_message -n -e "$NORMAL[$RED✗$NORMAL] \t \t " | tee -a $LOGFILE
  log_message -e "$NORMAL Fehlercode: $RED $? $NORMAL" | tee -a $LOGFILE
}

LF_Fehlerbehandlung_Y() {
	log_message -e $NORMAL "Das Script ist durchlaufen, es sind $GREEN keine Fehler $NORMAL vorgekommen, das $GREEN System wurde aktualisiert! $NORMAL"
}

LF_Fehlerbehandlung_N() {
	log_message -e $NORMAL "Es sind $RED Fehler $NORMAL(Fehlercode: $RED $FEHLER $NORMAL)$NORMAL vorgekommen! Bitte in das Logfile unter folgendem Pfad einsehen:$YELLOW $LOGFILE"
}

LF_Fehlerbehandlung_RKH() {
	log_message -e $GREEN "RKHUNTER $NORMAL wurde ebenfalls $GREEN aktualisiert $NORMAL und ein $GREEN Property Update wurde ausgeführt! $NORMAL"
}

LF_Logline() {
	echo "=== NEUER SCRIPTLAUF ===">>$LOGFILE
}

LF_Zeitausgabe() {
	log_message -e $NORMAL "Die Aktualisierung hat $YELLOW $((runtime / 60)) Minuten $NORMAL und $YELLOW $((runtime % 60)) Sekunden $NORMAL gedauert."
}

LF_Zeitausgabe_Logfile() {
	echo "die Aktualisierung hat $((runtime / 60)) Minuten und $((runtime % 60)) Sekunden gedauert.">>$LOGFILE
}

LF_LogRotationMaxAge() {
	log_message -e "Alte Logfiles (älter als $max_log_age Tage) gelöscht \t $NORMAL[$GREEN✓$NORMAL]"
}

# Logfile Ausgaben

LFA_Upgrade_Y="Upgrade erfolgreich ausgeführt"
LFA_Upgrade_N="Fehler bei apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove erfolgreich ausgeführt"
LFA_Autoremove_N="Fehler bei apt-get autoremove -y -q"
LFA_Notification_Option_notSet="Keine externe Benachrichtigungsoption aktiviert"
LFA_LOGROTATION_Err_1="--Kein Logfile für Rotation--"
LFA_NOOLDLOGS="Keine Logfiles älter als $LOGFILE_MAX_AGE Tage gefunden \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Prüfung auf RKHunter"
LV_RKHunterFound="RKHunter auf System gefunden"
LV_RKHunterUpd="RKHunter updaten und property update"
LV_RKHunterUpd_log="RK-Hunter update und propupd ausgeführt"
LV_RKHunterCheckInfo="Rootkit Check kann einige Zeit dauern"
LV_RKHunterCheck="RKHunter Check auf Rootkits"

##### Nextcloud ####
LV_NC_APPS="Nextcloud Apps aktualisieren"

