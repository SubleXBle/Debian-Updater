#!/bin/bash

# Pfad zur Konfigurationsdatei
config_file="DEB_UPD_config.sh"

# Überprüfen jeder Variablen in der Konfigurationsdatei
while IFS='=' read -r var value; do
    # Zeilen mit Kommentaren ignorieren
    value=$(echo "$value" | sed 's/#.*//')  # Entfernt den Kommentar

    # Entfernt Leerzeichen vor und nach der Variablen (einschließlich unsichtbarer Zeichen)
    value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Debugging-Ausgabe, um den bereinigten Wert zu überprüfen
    echo "DEBUG: Nach dem Trimmen ist $var gesetzt auf: '$value'"  # Zeigt den Wert mit Anführungszeichen an, um Leerzeichen zu erkennen

    # Gehe nur auf Variablen ein, die auf true oder false gesetzt sind
    if [[ "$value" == "true" || "$value" == "false" ]]; then
        log_message "Variable $var ist richtig gesetzt auf $value." >> /dev/null
    # Überprüft, ob die Variable nicht leer ist und nicht "true" oder "false" ist
    elif [[ -n "$value" ]]; then
        log_message "ERROR: $var ist nicht korrekt gesetzt - es ist gesetzt auf: $value"
        log_message "ERROR: $var ist nicht korrekt gesetzt - es ist gesetzt auf: $value. Skript wird gestoppt." >> $LOGFILE
        FEHLER="VARS NICHT KORREKT SETZT"
        exit 1
    fi
done < "$config_file"
