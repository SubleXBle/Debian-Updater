#!/bin/bash

# Path to the config File
config_file="DEB_UPD_config.sh"

# Check for every Variable in the Config File
while IFS='=' read -r var value; do
    # remove spaces bevore and after the variable
    value=$(echo "$value" | xargs)

    # Go only for Variables that are set to true or false
    if [[ "$value" == "true" || "$value" == "false" ]]; then
        log_message "Variable $var ist richtig gesetzt auf $value." >> /dev/null
    elif [[ -n "$value" ]]; then
        log_message "ERROR: $var is not set correct - it is set to: $value"
        log_message "ERROR: $var is not set correct - it is set to: $value" >> $LOGFILE
        FEHLER="VARS NOT SET CORRECT"
    fi
done < <(grep -E '^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*=[[:space:]]*(true|false)' "$config_file")
