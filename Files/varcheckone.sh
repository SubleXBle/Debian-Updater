#!/bin/bash

# Path to the config File
config_file="DEB_UPD_config.sh"

# Check for every Variable in the Config File
while IFS='=' read -r var value; do
    # Ignore lines with comments
    value=$(echo "$value" | sed 's/#.*//')  # Entfernt den Kommentar

    # Remove spaces before and after the variable (including invisible characters)
    value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Debugging output to check the cleaned value
    echo "DEBUG: After trimming, $var is set to: '$value'"  # Shows the value with quotes to detect spaces

    # Go only for Variables that are set to true or false
    if [[ "$value" == "true" || "$value" == "false" ]]; then
        log_message "Variable $var ist richtig gesetzt auf $value." >> /dev/null
    elif [[ -n "$value" ]]; then
        log_message "ERROR: $var is not set correct - it is set to: $value"
        log_message "ERROR: $var is not set correct - it is set to: $value Stopping Script" >> $LOGFILE
        FEHLER="VARS NOT SET CORRECT"
        exit 1
    fi
done < "$config_file"
