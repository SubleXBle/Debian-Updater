#!/bin/bash

# Farben für Output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Der TARGET_DIR Pfad wird auf das aktuelle Verzeichnis gesetzt
TARGET_DIR="$(pwd)"  # Aktueller Pfad des Skripts
REPO_URL="https://github.com/SubleXBle/Debian-Updater.git"

# Logfile
LOGFILE="$TARGET_DIR/update.log"

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# Überprüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    log_message "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
    exit 1
fi

log_message "Updater repository is being updated..."

# Flag für Änderungen
UPDATED=false

# Überprüfen, ob das Zielverzeichnis existiert und ein Git-Repository ist
if [ -d "$TARGET_DIR" ]; then
    if [ -d "$TARGET_DIR/.git" ]; then
        log_message "The directory $TARGET_DIR is a Git repository."
        cd "$TARGET_DIR" || exit

        # Ermittelt den Standard-Branch des Repositories
        BRANCH_NAME=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
        if [ -z "$BRANCH_NAME" ]; then
            log_message "${RED}Error: Unable to determine the default branch.${NORMAL}"
            exit 1
        fi

        log_message "Pulling branch: $BRANCH_NAME"
        
        # Repository aktualisieren und überprüfen, ob Änderungen vorliegen
        if git fetch origin "$BRANCH_NAME" && [ "$(git rev-parse HEAD)" != "$(git rev-parse @{u})" ]; then
            log_message "Changes detected. Pulling updates..."
            if git pull origin "$BRANCH_NAME"; then
                log_message "${GREEN}Repository successfully updated.${NORMAL}"
                UPDATED=true
            else
                log_message "${RED}Error updating the repository.${NORMAL}"
                exit 1
            fi
        else
            log_message "${YELLOW}No changes detected. The repository is up-to-date.${NORMAL}"
        fi
    else
        log_message "${YELLOW}The directory $TARGET_DIR exists but is not a Git repository.${NORMAL}"
        log_message "Deleting the directory and cloning the repository..."
        rm -rf "$TARGET_DIR"
        if git clone "$REPO_URL" "$TARGET_DIR"; then
            log_message "${GREEN}Repository successfully cloned.${NORMAL}"
            UPDATED=true
        else
            log_message "${RED}Error cloning the repository.${NORMAL}"
            exit 1
        fi
    fi
else
    log_message "The directory $TARGET_DIR does not exist."
    log_message "Cloning the repository from $REPO_URL to $TARGET_DIR..."
    if git clone "$REPO_URL" "$TARGET_DIR"; then
        log_message "${GREEN}Repository successfully cloned.${NORMAL}"
        UPDATED=true
    else
        log_message "${RED}Error cloning the repository.${NORMAL}"
        exit 1
    fi
fi

# Dateien ausführbar machen, wenn ein Update stattgefunden hat
if [ "$UPDATED" = true ]; then
    log_message "Making 'Updater-Update.sh' and 'Debian-Updater.sh' executable..."
    chmod +x "$TARGET_DIR/Updater-Update.sh" "$TARGET_DIR/Debian-Updater.sh"
    if [ $? -eq 0 ]; then
        log_message "${GREEN}Files have been successfully made executable.${NORMAL}"
    else
        log_message "${RED}Error setting executable permissions on the files.${NORMAL}"
        exit 1
    fi
else
    log_message "${YELLOW}No updates were made. Skipping making files executable.${NORMAL}"
fi

log_message "${GREEN}Script completed successfully.${NORMAL}"
