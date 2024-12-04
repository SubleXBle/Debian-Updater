#!/bin/bash

# Colors for output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Repository URL und Branch-Name
REPO_URL="https://github.com/SubleXBle/Debian-Updater.git"
BRANCH_NAME="V0.9"  # Beispiel: Branch "V0.9"

# Zielpfad für das Repository
TARGET_DIR="/opt/Debian-Updater"

# Funktion zur Überprüfung, ob Git installiert ist
check_git_installed() {
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
        exit 1
    fi
}

# Funktion zur Überprüfung, ob der Zielordner existiert und ggf. das Repository klonen
clone_or_pull_repo() {
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}The target directory does not exist. Cloning the repository...${NORMAL}"
        git clone -b "$BRANCH_NAME" "$REPO_URL" "$TARGET_DIR"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Repository successfully cloned.${NORMAL}"
        else
            echo -e "${RED}Error cloning the repository.${NORMAL}"
            exit 1
        fi
    else
        echo -e "${BLUE}Repository already exists. Pulling the latest changes from branch '$BRANCH_NAME'...${NORMAL}"
        cd "$TARGET_DIR" || exit
        git pull origin "$BRANCH_NAME"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Repository successfully updated.${NORMAL}"
        else
            echo -e "${RED}Error pulling the repository updates.${NORMAL}"
            exit 1
        fi
    fi
}

# Überprüfen, ob Git installiert ist
check_git_installed

# Klonen oder Pullen des Repositories
clone_or_pull_repo

# Setzen der Ausführungsberechtigungen für die Skripte
chmod +x "$TARGET_DIR/Debian-Updater.sh"
chmod +x "$TARGET_DIR/Updater-Update.sh"

echo -e "${GREEN}Repository is ready to use.${NORMAL}"
