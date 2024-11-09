#!/bin/bash

# Path to the config File
config_file="DEB_UPD_config.sh"

# Function to Check for a Valid Path
is_valid_path() {
    local path="$1"
    # Checks if the path exists or can be created
    if [[ -e "$path" || ( -d "$(dirname "$path")" ) ]]; then
        return 0
    else
        return 1
    fi
}

# Load and Check Config File
source "$config_file"

# Debugging Ausgabe: Überprüfe, was nach dem Laden des Konfigurationsdatei passiert
#echo "DEBUG: Nach dem Laden des Konfigurationsdatei:"
#declare -p UV_LNG

# Trim variables explicitly
UV_LNG=$(echo "$UV_LNG" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
UV_LOG=$(echo "$UV_LOG" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
LOGFILE=$(echo "$LOGFILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
LOGFILE_MAX_AGE=$(echo "$LOGFILE_MAX_AGE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Überprüfe erneut den Wert von UV_LNG
#echo "DEBUG: Nach dem Trimmen von UV_LNG:"
#declare -p UV_LNG

# Check for Variable Data
# Language
if [[ "$UV_LNG" != "DE" && "$UV_LNG" != "EN" && "$UV_LNG" != "SP" ]]; then
    log_message "ERROR: UV_LNG has to be 'DE', 'EN' or 'SP' but it is: $UV_LNG"
    echo "ERROR: UV_LNG has to be 'DE', 'EN' or 'SP' but it is: $UV_LNG" >> $LOGFILE
    exit 1
else
    echo "Die Variable UV_LNG ist korrekt gesetzt auf $UV_LNG." >> /dev/null
fi

# LogLevel Check
if [[ "$UV_LOG" != "quiet" && "$UV_LOG" != "medium" && "$UV_LOG" != "all" ]]; then
    log_message "ERROR: UV_LOG has to be 'quiet', 'medium' or 'all' but it is set to: $UV_LOG"
    echo "ERROR: UV_LOG has to be 'quiet', 'medium' or 'all' but it is set to: $UV_LOG" >> $LOGFILE
    exit 1
else
    echo "Die Variable UV_LOG ist korrekt gesetzt auf $UV_LOG." >> /dev/null
fi

# Path Validation
if ! is_valid_path "$LOGFILE"; then
    log_message "ERROR: LOGFILE is not a valid Path: $LOGFILE"
    echo "ERROR: LOGFILE is not a valid Path: $LOGFILE" >> $LOGFILE
    exit 1
else
    echo "Die Variable LOGFILE ist korrekt gesetzt auf einen gültigen Pfad: $LOGFILE." >> /dev/null
fi

# Check if Logfile max age is a number
if ! [[ "$LOGFILE_MAX_AGE" =~ ^[0-9]+$ ]]; then
    log_message "ERROR: LOGFILE_MAX_AGE has to be a valid number but it is set to: $LOGFILE_MAX_AGE"
    echo "ERROR: LOGFILE_MAX_AGE has to be a valid number but it is set to: $LOGFILE_MAX_AGE" >> $LOGFILE
    exit 1
else
    echo "Die Variable LOGFILE_MAX_AGE ist korrekt gesetzt auf $LOGFILE_MAX_AGE." >> /dev/null
fi
