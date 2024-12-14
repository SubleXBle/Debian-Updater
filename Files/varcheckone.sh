#!/bin/bash

# Check if everything is in place

FILES=(
    "DEB_UPD_config.sh"
    "$LOGFILE"
)

check_them_files() {
    #echo "running check ..."
    for file in "${FILES[@]}"; do
        if [ -f "$file" ]; then
            #echo "✅ Die Datei '$file' ist vorhanden."
        else
            echo "❌ Could NOT find '$file' !"
            echo stopping script!
            exit;
        fi
    done
}

# Skript starten
check_them_files
