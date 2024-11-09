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

# Check for Variable Data
# Language
if [[ "$UV_LNG" != "DE" && "$UV_LNG" != "EN" && "$UV_LNG" != "SP" ]]; then
    echo "ERROR: UV_LNG has to be 'DE', 'EN' or 'SP' but it is: $UV_LNG"
else
    echo "Die Variable UV_LNG ist korrekt gesetzt auf $UV_LNG." >> /dev/null
fi
# LogLevel Check
if [[ "$UV_LOG" != "quiet" && "$UV_LOG" != "medium" && "$UV_LOG" != "all" ]]; then
    echo "ERROR: UV_LOG has to be 'quiet', 'medium' or 'all' but it is set to: $UV_LOG"
else
    echo "Die Variable UV_LOG ist korrekt gesetzt auf $UV_LOG." >> /dev/null
fi
# Path Validation
if ! is_valid_path "$LOGFILE"; then
    echo "ERROR: LOGFILE is not a valid Path: $LOGFILE"
else
    echo "Die Variable LOGFILE ist korrekt gesetzt auf einen gültigen Pfad: $LOGFILE." >> /dev/null
fi
# Check if Logfile max age is a number
if ! [[ "$LOGFILE_MAX_AGE" =~ ^[0-9]+$ ]]; then
    echo "ERROR: LOGFILE_MAX_AGE has to be a valid number but it is set to: $LOGFILE_MAX_AGE"
else
    echo "Die Variable LOGFILE_MAX_AGE ist korrekt gesetzt auf $LOGFILE_MAX_AGE." >> /dev/null
fi
