#!/bin/bash

# Pfad zum Config-File
config_file="DEB_UPD_config.sh"

# Funktion zur Prüfung eines gültigen Dateipfads
is_valid_path() {
    local path="$1"
    # Überprüft, ob der Pfad existiert oder ob das Verzeichnis erstellt werden könnte
    if [[ -e "$path" || ( -d "$(dirname "$path")" ) ]]; then
        return 0
    else
        return 1
    fi
}

# Laden und Überprüfung der Variablen
source "$config_file"

# Überprüfen der Variablenwerte
if [[ "$UV_LNG" != "DE" && "$UV_LNG" != "EN" && "$UV_LNG" != "SP" ]]; then
    echo "Fehler: UV_LNG muss auf 'DE', 'EN' oder 'SP' gesetzt sein. Aktueller Wert: $UV_LNG"
else
    echo "Die Variable UV_LNG ist korrekt gesetzt auf $UV_LNG."
fi

if [[ "$UV_LOG" != "quiet" && "$UV_LOG" != "medium" && "$UV_LOG" != "all" ]]; then
    echo "Fehler: UV_LOG muss auf 'quiet', 'medium' oder 'all' gesetzt sein. Aktueller Wert: $UV_LOG"
else
    echo "Die Variable UV_LOG ist korrekt gesetzt auf $UV_LOG."
fi

if ! is_valid_path "$LOGFILE"; then
    echo "Fehler: LOGFILE ist kein gültiger Pfad. Aktueller Wert: $LOGFILE"
else
    echo "Die Variable LOGFILE ist korrekt gesetzt auf einen gültigen Pfad: $LOGFILE."
fi

if ! [[ "$LOGFILE_MAX_AGE" =~ ^[0-9]+$ ]]; then
    echo "Fehler: LOGFILE_MAX_AGE muss eine Zahl sein. Aktueller Wert: $LOGFILE_MAX_AGE"
else
    echo "Die Variable LOGFILE_MAX_AGE ist korrekt gesetzt auf $LOGFILE_MAX_AGE."
fi
