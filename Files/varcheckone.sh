#!/bin/bash

# Pfad zur Konfigurationsdatei
config_file="DEB_UPD_config.sh"

# Überprüfen jeder Variablen in der Konfigurationsdatei
while IFS='=' read -r var value; do
    # Zeilen mit Kommentaren ignorieren
    value=$(echo "$value" | sed 's/#.*//')  # Entfernt den Kommentar

    # Entfernt Leerzeichen vor und nach der Variablen (einschließlich unsichtbarer Zeichen)
    value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Entfernen von Anführungszeichen, falls vorhanden
    value=$(echo "$value" | sed 's/^"\(.*\)"$/\1/')

    # Debugging-Ausgabe, um den bereinigten Wert zu überprüfen
    echo "DEBUG: Nach dem Trimmen ist $var gesetzt auf: '$value'"  # Zeigt den Wert mit Anführungszeichen an, um Leerzeichen zu erkennen

    # Überspringe Variablen, die auf DE, EN oder SP gesetzt sind (wie UV_LNG) oder Logging-bezogene Variablen wie UV_LOG und LOGFILE
    if [[ "$var" == "UV_LNG" ]] || [[ "$var" == "UV_LOG" ]] || [[ "$var" == "LOGFILE" ]]; then
        continue
    fi

    # Gehe nur auf Variablen ein, die auf true oder false gesetzt sind
    if [[ "$value" == "true" || "$value" == "false" ]]; then
        log_message "Variable $var ist richtig gesetzt auf $value." >> /dev/null
    # Überprüft ob die Variable eine Zahl ist (für LOGFILE_MAX_AGE)
    elif [[ "$var" == "LOGFILE_MAX_AGE" ]]; then
        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
            log_message "ERROR: $var ist keine gültige Zahl - es ist gesetzt auf: $value"
            log_message "ERROR: $var ist keine gültige Zahl - es ist gesetzt auf: $value. Skript wird gestoppt." >> $LOGFILE
            FEHLER="UNGÜLTIGE ZAHL FÜR $var"
            exit 1
        fi
    # Alle anderen Variablen, die nicht 'true' oder 'false' sind, ignorieren
    elif [[ -n "$value" ]]; then
        log_message "ERROR: $var ist nicht korrekt gesetzt - es ist gesetzt auf: $value"
        log_message "ERROR: $var ist nicht korrekt gesetzt - es ist gesetzt auf: $value. Skript wird gestoppt." >> $LOGFILE
        FEHLER="VARS NICHT KORREKT SETZT"
        exit 1
    fi
done < "$config_file"
