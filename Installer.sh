#!/bin/bash

# Colors for output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Repository URL and Branch-Name
REPO_URL="https://github.com/SubleXBle/Debian-Updater.git"
BRANCH_NAME="main"

# Repository Target Path
# Set default path
TARGET_DIR="/opt/Debian-Updater"

# Ask the user if they want to use a custom path
echo "Do you want to use a custom path? (Y/N): "
read -r USE_CUSTOM_PATH

# Convert input to lowercase to handle Y/y and N/n
USE_CUSTOM_PATH=${USE_CUSTOM_PATH,,}

if [[ "$USE_CUSTOM_PATH" == "y" ]]; then
    # Prompt the user to enter a path
    echo "Please enter the desired path (or press Enter to use the default path): "
    read -r USER_PATH

    # Check if the user entered a path
    if [[ -z "$USER_PATH" ]]; then
        echo "No path entered. Default path will be used: $TARGET_DIR"
    else
        # Check if the path exists or can be created
        if mkdir -p "$USER_PATH" 2>/dev/null; then
            TARGET_DIR="$USER_PATH"
            echo "Path successfully set to: $TARGET_DIR"
        else
            echo "Invalid path. Default path will be used: $TARGET_DIR"
        fi
    fi
else
    echo "Default path will be used: $TARGET_DIR"
fi

# Display the final path
echo "Using path: $TARGET_DIR"

# Check if Git is installed
check_git_installed() {
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
        exit 1
    fi
}

# Check Target Dir and clone repo if exists
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

# Check for Git Installation
check_git_installed

# Clone or pull repo
clone_or_pull_repo

# make Updater and Updater-Updater executeable
chmod +x "$TARGET_DIR/Debian-Updater.sh"
chmod +x "$TARGET_DIR/Updater-Update.sh"

echo -e "${GREEN}Repository is ready to use.${NORMAL}"
