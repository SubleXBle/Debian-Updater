#!/bin/bash

# Standardpfade als readonly Konstanten
readonly DEFAULT_NC_PATH="/path/to/your/Nextcloud"
readonly DEFAULT_MW_PATH="/path/to/Mediawiki"
readonly DEFAULT_LOGFILE="/var/log/debian-updater.log"

# Funktion zur Überprüfung von Pfaden
check_path_variable() {
    local var_name=$1       # Name der zu prüfenden Variablen
    local var_value=$2      # Wert der Variablen (aktuell gesetzter Pfad)
    local default_value=$3  # Standardpfad

    # Fallback verwenden, falls var_value leer ist
    local value_to_check=${var_value:-$default_value}

    # Prüfung des Pfads
    if [[ -d "$value_to_check" ]]; then
        if [[ "$value_to_check" == "$default_value" ]]; then
            echo "Info: Der Pfad $var_name verwendet den Standardpfad ($default_value)."
        else
            echo "Info: Der Pfad $var_name ist gültig ($value_to_check)."
        fi
    else
        echo "Fehler: Der Pfad $var_name ($value_to_check) ist ungültig und weicht vom Standardpfad ($default_value) ab."
    fi
}

# Funktion zur Überprüfung von 'true/false'-Variablen
check_bool_variable() {
    local var_name=$1
    local var_value=$2

    if [[ "$var_value" != "true" && "$var_value" != "false" ]]; then
        echo "Fehler: Die Variable $var_name ist nicht auf 'true' oder 'false' gesetzt (aktuell: $var_value)."
    fi
}

# Funktion zur Überprüfung von Sprachvariablen
check_language_variable() {
    local var_name=$1
    local var_value=$2

    if [[ "$var_value" != "DE" && "$var_value" != "EN" && "$var_value" != "SP" ]]; then
        echo "Fehler: Die Variable $var_name muss auf 'DE', 'EN' oder 'SP' gesetzt sein (aktuell: $var_value)."
    fi
}

# Funktion zur Überprüfung von Zahlen (z.B. für LOGFILE_MAX_AGE)
check_number_variable() {
    local var_name=$1
    local var_value=$2

    if ! [[ "$var_value" =~ ^[0-9]+$ ]]; then
        echo "Fehler: Die Variable $var_name muss eine Zahl enthalten (aktuell: $var_value)."
    fi
}

# Hauptfunktion zur Prüfung der Variablen
validate_config() {
    # Pfadvariablen prüfen
    check_path_variable "UV_NC_OCC_PATH" "$UV_NC_OCC_PATH" "$DEFAULT_NC_PATH"
    check_path_variable "UV_MW_PATH" "$UV_MW_PATH" "$DEFAULT_MW_PATH"
    check_path_variable "LOGFILE" "$LOGFILE" "$DEFAULT_LOGFILE"

    # Boolean-Variablen prüfen
    check_bool_variable "UV_PUSHOVER" "$UV_PUSHOVER"
    check_bool_variable "UV_TELEGRAM" "$UV_TELEGRAM"
    check_bool_variable "UV_GOTIFY" "$UV_GOTIFY"
    check_bool_variable "UV_DISCORD" "$UV_DISCORD"
    check_bool_variable "UV_EMAIL" "$UV_EMAIL"
    check_bool_variable "UV_TEAMS" "$UV_TEAMS"
    check_bool_variable "UV_RKHUNTER" "$UV_RKHUNTER"
    check_bool_variable "UV_RKH_CHECK" "$UV_RKH_CHECK"

    # Sprachvariablen prüfen
    check_language_variable "UV_LNG" "$UV_LNG"

    # Zahl-Variablen prüfen
    check_number_variable "LOGFILE_MAX_AGE" "$LOGFILE_MAX_AGE"
}
