#!/bin/bash

# Colors for output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Define the target directory
TARGET_DIR="/home/USER/Debian-Updater"  # Change this as needed

# Repository URL for the Debian-Updater
REPO_URL="https://github.com/SubleXBle/Debian-Updater.git"

echo -e "$NORMAL"
echo "Checking repository: $REPO_URL"
echo "Target directory: $TARGET_DIR"

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
    exit 1
fi

# Check if the target directory exists and is a Git repository
if [ -d "$TARGET_DIR" ]; then
    if [ -d "$TARGET_DIR/.git" ]; then
        echo "The directory $TARGET_DIR is a Git repository."
        cd "$TARGET_DIR" || exit
        
        echo "Checking for changes in the repository..."
        git fetch
        LOCAL_HASH=$(git rev-parse HEAD)
        REMOTE_HASH=$(git rev-parse @{u})
        
        if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
            echo -e "${YELLOW}Changes detected in the repository.${NORMAL}"
            echo "Updating repository with 'git pull'..."
            if git pull; then
                echo -e "${GREEN}Repository successfully updated.${NORMAL}"
            else
                echo -e "${RED}Error updating the repository.${NORMAL}"
                exit 1
            fi
        else
            echo -e "${GREEN}No changes detected. The repository is up-to-date.${NORMAL}"
        fi
    else
        echo -e "${YELLOW}The directory $TARGET_DIR exists but is not a Git repository.${NORMAL}"
        echo "Removing the directory and cloning the repository again."
        rm -rf "$TARGET_DIR"
        if git clone "$REPO_URL" "$TARGET_DIR"; then
            echo -e "${GREEN}Repository successfully cloned.${NORMAL}"
        else
            echo -e "${RED}Error cloning the repository.${NORMAL}"
            exit 1
        fi
    fi
else
    echo "The directory $TARGET_DIR does not exist."
    echo "Cloning the repository from $REPO_URL to $TARGET_DIR..."
    if git clone "$REPO_URL" "$TARGET_DIR"; then
        echo -e "${GREEN}Repository successfully cloned.${NORMAL}"
    else
        echo -e "${RED}Error cloning the repository.${NORMAL}"
        exit 1
    fi
fi
