#!/bin/bash

# Farben für Output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Zielverzeichnis setzen
TARGET_DIR="$(pwd)"  # Aktuelles Verzeichnis des Skripts

# Überprüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
    exit 1
fi

# Funktion zum Loggen
log_message() {
    echo -e "$1"
}

# Prüfen, ob Zielverzeichnis ein Git-Repository ist
if [ -d "$TARGET_DIR/.git" ]; then
    cd "$TARGET_DIR" || exit

    # Lokale Änderungen prüfen
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}Local changes detected in $TARGET_DIR.${NORMAL}"
        echo "How would you like to proceed?"
        echo "1. Overwrite (discard changes)"
        echo "2. Backup (stash changes)"
        echo "3. Cancel update"
        read -rp "Enter your choice (1-3): " choice

        case $choice in
            1) 
                log_message "${YELLOW}Discarding local changes...${NORMAL}"
                git reset --hard
                ;;
            2) 
                log_message "${YELLOW}Backing up local changes...${NORMAL}"
                git stash
                ;;
            3) 
                log_message "${RED}Update canceled by user.${NORMAL}"
                exit 0
                ;;
            *) 
                log_message "${RED}Invalid choice. Update canceled.${NORMAL}"
                exit 1
                ;;
        esac
    fi

    # Aktualisieren des Repositories
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
    log_message "${BLUE}Pulling updates from branch: $BRANCH_NAME...${NORMAL}"
    if git pull origin "$BRANCH_NAME"; then
        log_message "${GREEN}Repository successfully updated.${NORMAL}"
    else
        log_message "${RED}Error updating the repository.${NORMAL}"
        exit 1
    fi

else
    log_message "${YELLOW}$TARGET_DIR is not a Git repository. Cloning repository...${NORMAL}"
    if git clone "https://github.com/SubleXBle/Debian-Updater.git" "$TARGET_DIR"; then
        log_message "${GREEN}Repository successfully cloned.${NORMAL}"
    else
        log_message "${RED}Error cloning the repository.${NORMAL}"
        exit 1
    fi
fi

# Dateien nur ausführbar machen, wenn ein Update oder ein Clone erfolgte
if [ $? -eq 0 ]; then
    log_message "Making files 'Updater-Update.sh' and 'Debian-Updater.sh' executable..."
    chmod +x "$TARGET_DIR/Updater-Update.sh" "$TARGET_DIR/Debian-Updater.sh"
    if [ $? -eq 0 ]; then
        log_message "${GREEN}Files successfully made executable.${NORMAL}"
    else
        log_message "${RED}Error setting executable permissions.${NORMAL}"
        exit 1
    fi
fi
