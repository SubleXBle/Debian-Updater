#!/bin/bash

# Standardpfade, die nicht als Fehler erkannt werden sollen
DEFAULT_NC_PATH="/path/to/your/Nextcloud"
DEFAULT_MW_PATH="/path/to/Mediawiki"

# Funktion zur Überprüfung der 'true/false'-Variablen
check_bool_variable() {
    local var_name=$1
    local var_value=$2

    if [[ "$var_value" != "true" && "$var_value" != "false" ]]; then
        echo "Fehler: Die Variable $var_name ist nicht auf 'true' oder 'false' gesetzt (aktuell: $var_value)."
    fi
}

# Funktion zur Überprüfung von Pfaden
check_path_variable() {
    local var_name=$1
    local var_value=$2
    local default_value=$3

    if [[ "$var_value" != "$default_value" && ! -d "$var_value" ]]; then
        echo "Fehler: Der Pfad $var_name ($var_value) ist ungültig oder existiert nicht."
    fi
}

# Funktion zur Überprüfung der Sprachwahl (UV_LNG)
check_language_variable() {
    local var_name=$1
    local var_value=$2

    if [[ "$var_value" != "DE" && "$var_value" != "EN" && "$var_value" != "SP" ]]; then
        echo "Fehler: Die Variable $var_name muss auf 'DE', 'EN' oder 'SP' gesetzt sein (aktuell: $var_value)."
    fi
}

# Variablen aus der Konfigurationsdatei laden (Beispiel: UV_LNG, LOGFILE usw.)
UV_LNG="DE"
UV_UpgradeMode=false
UV_AutoremoveMode=true
UV_LOG="quiet"
LOGFILE="/var/log/Updater.log"
UV_KEEP_LOG=true
KILL_OLD_LOGS=false
LOGFILE_MAX_AGE=30
UV_PUSHOVER=false
UV_TELEGRAM=true
UV_GOTIFY=false
UV_DISCORD=true
UV_EMAIL=false
UV_TEAMS=true
UV_RKHUNTER=true
UV_RKH_CHECK=false
UV_NC_APP_Update=false
UV_NC_OCC_PATH="/path/to/your/Nextcloud"
UV_MW_Update=false
UV_MW_PATH="/path/to/Mediawiki"

# Überprüfung der 'true/false'-Variablen
check_bool_variable "UV_UpgradeMode" "$UV_UpgradeMode"
check_bool_variable "UV_AutoremoveMode" "$UV_AutoremoveMode"
check_bool_variable "UV_KEEP_LOG" "$UV_KEEP_LOG"
check_bool_variable "KILL_OLD_LOGS" "$KILL_OLD_LOGS"
check_bool_variable "UV_PUSHOVER" "$UV_PUSHOVER"
check_bool_variable "UV_TELEGRAM" "$UV_TELEGRAM"
check_bool_variable "UV_GOTIFY" "$UV_GOTIFY"
check_bool_variable "UV_DISCORD" "$UV_DISCORD"
check_bool_variable "UV_EMAIL" "$UV_EMAIL"
check_bool_variable "UV_TEAMS" "$UV_TEAMS"
check_bool_variable "UV_RKHUNTER" "$UV_RKHUNTER"
check_bool_variable "UV_RKH_CHECK" "$UV_RKH_CHECK"
check_bool_variable "UV_NC_APP_Update" "$UV_NC_APP_Update"
check_bool_variable "UV_MW_Update" "$UV_MW_Update"

# Überprüfung der Sprachwahl-Variable
check_language_variable "UV_LNG" "$UV_LNG"

# Überprüfung der Pfad-Variablen
check_path_variable "UV_NC_OCC_PATH" "$UV_NC_OCC_PATH" "$DEFAULT_NC_PATH"
check_path_variable "UV_MW_PATH" "$UV_MW_PATH" "$DEFAULT_MW_PATH"
check_path_variable "LOGFILE" "$LOGFILE" ""

# Optional: Weitere Pfadüberprüfungen können hier hinzugefügt werden
