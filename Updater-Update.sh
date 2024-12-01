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
    CHANGED_FILES=$(git diff --name-only)
    
    if [ -n "$CHANGED_FILES" ]; then
        echo -e "${YELLOW}Local changes detected in $TARGET_DIR.${NORMAL}"
        
        # Jede geänderte Datei einzeln abfragen
        for file in $CHANGED_FILES; do
            echo -e "${YELLOW}File changed: $file${NORMAL}"
            echo "How would you like to proceed with this file?"
            echo "1. Overwrite (discard changes)"
            echo "2. Backup (stash changes)"
            echo "3. Keep changes"
            read -rp "Enter your choice (1-3): " choice

            case $choice in
                1)
                    log_message "${YELLOW}Discarding changes for $file...${NORMAL}"
                    git checkout -- "$file"
                    ;;
                2)
                    log_message "${YELLOW}Backing up changes for $file...${NORMAL}"
                    git stash push -m "Backup $file"
                    ;;
                3)
                    log_message "${GREEN}Keeping changes for $file.${NORMAL}"
                    ;;
                *)
                    log_message "${RED}Invalid choice for file $file. Update canceled.${NORMAL}"
                    exit 1
                    ;;
            esac
        done
    else
        log_message "${GREEN}No local changes detected. Proceeding with update.${NORMAL}"
    fi

    # Branch ermitteln und prüfen
    BRANCH_NAME=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")
    if ! git show-ref --verify --quiet "refs/remotes/origin/$BRANCH_NAME"; then
        log_message "${RED}Error: Branch '$BRANCH_NAME' does not exist in the remote repository.${NORMAL}"
        echo -e "${YELLOW}Attempting to fetch the default branch...${NORMAL}"
        BRANCH_NAME=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
        if [ -z "$BRANCH_NAME" ]; then
            log_message "${RED}Error: Could not determine the default branch.${NORMAL}"
            exit 1
        fi
    fi

    # Repository aktualisieren
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
