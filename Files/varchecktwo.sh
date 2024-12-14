#!/bin/bash

# Standards from Files
DEFAULT_UV_NC_OCC_PATH="/path/to/your/Nextcloud"
DEFAULT_UV_MW_PATH="/path/to/Mediawiki"

# Check Boolean-Variables (true/false)
check_bool_variable() {
    local var_name=$1
    local var_value=$2
    if [[ "$var_value" != "true" && "$var_value" != "false" ]]; then
        echo "Fehler: Die Variable $var_name ist nicht auf 'true' oder 'false' gesetzt (aktuell: $var_value)."
    fi
}

# Check txt Vars
check_language_variable() {
    local var_name=$1
    local var_value=$2
    if [[ "$var_value" != "EN" && "$var_value" != "DE" && "$var_value" != "SP" ]]; then
        echo "Fehler: Die Variable $var_name muss auf 'EN', 'DE' oder 'SP' gesetzt sein (aktuell: $var_value)."
    fi
}

# Check Number-Vars
check_number_variable() {
    local var_name=$1
    local var_value=$2
    if ! [[ "$var_value" =~ ^[0-9]+$ ]]; then
        echo "Fehler: Die Variable $var_name muss eine Zahl sein (aktuell: $var_value)."
    fi
}

# Check Paths
check_path_variable() {
    local var_name=$1
    local var_value=$2
    local default_value=$3
    if [[ "$var_value" != "$default_value" && ! -d "$var_value" ]]; then
        echo "Fehler: Der Pfad $var_name ($var_value) ist ungültig oder existiert nicht."
    fi
}

# Checks
# Language Check
check_language_variable "UV_LNG" "$UV_LNG"

# Updater-Mode
check_bool_variable "UV_UpgradeMode" "$UV_UpgradeMode"
check_bool_variable "UV_AutoremoveMode" "$UV_AutoremoveMode"

# Logging Level
if [[ "$UV_LOG" != "quiet" && "$UV_LOG" != "medium" && "$UV_LOG" != "all" ]]; then
    echo "Fehler: Die Variable UV_LOG muss auf 'quiet', 'medium' oder 'all' gesetzt sein (aktuell: $UV_LOG)."
fi

# Skipping Logfile Handling
# Wenn du die Logfile-Überprüfung überspringen möchtest, wurde sie hier entfernt.

check_bool_variable "UV_KEEP_LOG" "$UV_KEEP_LOG"
check_bool_variable "KILL_OLD_LOGS" "$KILL_OLD_LOGS"
check_number_variable "LOGFILE_MAX_AGE" "$LOGFILE_MAX_AGE"

# Notification Types
check_bool_variable "UV_PUSHOVER" "$UV_PUSHOVER"
check_bool_variable "UV_TELEGRAM" "$UV_TELEGRAM"
check_bool_variable "UV_GOTIFY" "$UV_GOTIFY"
check_bool_variable "UV_DISCORD" "$UV_DISCORD"
check_bool_variable "UV_EMAIL" "$UV_EMAIL"
check_bool_variable "UV_TEAMS" "$UV_TEAMS"

# Notification Options
check_bool_variable "UV_LOG2MSG" "$UV_LOG2MSG"
check_bool_variable "UV_NotifyOnlyOnError" "$UV_NotifyOnlyOnError"

# RKHunter-Options
check_bool_variable "UV_RKHUNTER" "$UV_RKHUNTER"
check_bool_variable "UV_RKH_CHECK" "$UV_RKH_CHECK"

# Nextcloud-Options
check_bool_variable "UV_NC_APP_Update" "$UV_NC_APP_Update"
check_path_variable "UV_NC_OCC_PATH" "$UV_NC_OCC_PATH" "$DEFAULT_UV_NC_OCC_PATH"

# MediaWiki-Options
check_bool_variable "UV_MW_Update" "$UV_MW_Update"
check_path_variable "UV_MW_PATH" "$UV_MW_PATH" "$DEFAULT_UV_MW_PATH"
