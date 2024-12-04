#!/bin/bash

# This File just downloads the Repo via Git

# Colors for output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Repository URL
REPO_URL="https://github.com/SubleXBle/Debian-Updater.git"

# Default target path
DEFAULT_PATH="/opt/Debian-Updater"

# Function to get the target path from the user
get_target_path() {
    # Suggest the default path
    echo -e "${BLUE}This will download the Debian-Updater Repository."
    echo -e "${NORMAL}Would you like to download the repository to the path ${YELLOW} '$DEFAULT_PATH' ${NORMAL}? ${YELLOW} (y/n): ${NORMAL}"
    read -p "(Press 'y' for the suggested path or 'n' for another path): " RESPONSE

    if [[ "$RESPONSE" =~ ^[Yy]$ ]]; then
        TARGET_DIR="$DEFAULT_PATH"
    else
        echo -e "${BLUE}Please use the full Path e.g.: /opt/Debian-Updater or /home/user/Debian-Updater ${NORMAL}"
        read -p "Enter the target path where the repository should be downloaded: " TARGET_DIR
        # Check if the path is valid
        if [ -z "$TARGET_DIR" ]; then
            echo -e "${RED}Error: No path specified. The script will exit.${NORMAL}"
            exit 1
        fi
    fi

    # Check if the path exists
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}The path does not exist. It will now be created.${NORMAL}"
        mkdir -p "$TARGET_DIR"
    fi
}

# Get the target path from the user
get_target_path

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
    exit 1
fi

# Change to the target directory
cd "$TARGET_DIR" || exit

# Check if the directory is already a Git repository
if [ -d ".git" ]; then
    echo -e "${BLUE}Repository already exists. Updating the repository with 'git pull'...${NORMAL}"
    git pull origin main
else
    echo -e "${YELLOW}Repository does not exist. Cloning the repository from GitHub...${NORMAL}"
    git clone "$REPO_URL" "$TARGET_DIR"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Repository successfully cloned.${NORMAL}"
    else
        echo -e "${RED}Error cloning the repository.${NORMAL}"
        exit 1
    fi
fi

# Set file permissions
chmod +x "$TARGET_DIR/Debian-Updater.sh"
chmod +x "$TARGET_DIR/Updater-Update.sh"
