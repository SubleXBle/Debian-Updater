#!/bin/bash

# Colors for output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# The TARGET_DIR path is set to the current directory
TARGET_DIR="$(pwd)"

# Default branch if not provided
DEFAULT_BRANCH="main"

# Function to check if Git is installed
check_git_installed() {
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NORMAL}"
        exit 1
    fi
}

# Function to fetch and update the repository
update_repo() {
    echo -e "$NORMAL"
    echo "Updating the Updater repository..."

    if [ -d "$TARGET_DIR" ] && [ -d "$TARGET_DIR/.git" ]; then
        echo "The directory $TARGET_DIR is a Git repository."
        cd "$TARGET_DIR" || exit

        # Use the provided branch or default to the main branch
        BRANCH_NAME="${1:-$DEFAULT_BRANCH}"
        
        echo -e "${BLUE}Pulling branch: $BRANCH_NAME${NORMAL}"

        # Update the repository (only fetch)
        echo "Fetching changes from the repository with 'git fetch origin $BRANCH_NAME'..."
        git fetch origin "$BRANCH_NAME"
        
        # Identify files that have changed in the repository
        CHANGED_FILES=$(git diff --name-only origin/"$BRANCH_NAME")

        if [ -z "$CHANGED_FILES" ]; then
            echo -e "${YELLOW}No changes found in the repository.${NORMAL}"
            exit 0
        fi

        # Inform the user about changes and ask for decisions
        for FILE in $CHANGED_FILES; do
            if [ -f "$FILE" ]; then
                echo -e "${YELLOW}The file '$FILE' has been modified locally.${NORMAL}"
                echo "What should be done with this file?"
                echo "1) Create a backup of the file (.BAK) and update the file"
                echo "2) Update the file without a backup"
                echo "3) Skip the file"
                echo "4) Cancel"
                read -p "Choose an option (1-4): " option

                case $option in
                    1)
                        echo "Creating a backup of the file '$FILE' as '$FILE.BAK'."
                        cp "$FILE" "$FILE.BAK"
                        echo "Downloading the updated version of the file '$FILE'."
                        git checkout origin/"$BRANCH_NAME" -- "$FILE"
                        ;;
                    2)
                        echo "Downloading the updated version of the file '$FILE' without a backup."
                        git checkout origin/"$BRANCH_NAME" -- "$FILE"
                        ;;
                    3)
                        echo "Skipping the file '$FILE'."
                        ;;
                    4)
                        echo "Script cancelled by user."
                        exit 1
                        ;;
                    *)
                        echo -e "${RED}Invalid option. The file '$FILE' will be skipped.${NORMAL}"
                        ;;
                esac
            else
                echo -e "${YELLOW}The file '$FILE' does not exist locally. It will be downloaded.${NORMAL}"
                git checkout origin/"$BRANCH_NAME" -- "$FILE"
            fi
        done

        # Make files executable
        echo "Making 'Updater-Update.sh' and 'Debian-Updater.sh' executable..."
        chmod +x "$TARGET_DIR/Updater-Update.sh" "$TARGET_DIR/Debian-Updater.sh"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Files were successfully made executable.${NORMAL}"
        else
            echo -e "${RED}Error setting executable permissions on the files.${NORMAL}"
            exit 1
        fi
    else
        echo "The directory $TARGET_DIR is not a Git repository or does not exist."
        echo "Cloning the repository from https://github.com/SubleXBle/Debian-Updater.git to $TARGET_DIR..."
        if git clone "https://github.com/SubleXBle/Debian-Updater.git" "$TARGET_DIR"; then
            echo -e "${GREEN}Repository cloned successfully.${NORMAL}"
            cd "$TARGET_DIR" || exit

            # After cloning, checkout the specified branch or default branch
            BRANCH_NAME="${1:-$DEFAULT_BRANCH}"
            git checkout "$BRANCH_NAME"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Successfully switched to branch $BRANCH_NAME.${NORMAL}"
            else
                echo -e "${RED}Failed to switch to branch $BRANCH_NAME.${NORMAL}"
                exit 1
            fi
        else
            echo -e "${RED}Error cloning the repository.${NORMAL}"
            exit 1
        fi
    fi
}

# Function to delete the installer file
delete_installer() {
    INSTALLER_FILE="$TARGET_DIR/Installer.sh"

    if [ -f "$INSTALLER_FILE" ]; then
        echo -e "${YELLOW}The file 'Installer.sh' will now be deleted.${NORMAL}"
        rm -f "$INSTALLER_FILE"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}The file was successfully deleted.${NORMAL}"
        else
            echo -e "${RED}Error deleting the file.${NORMAL}"
            exit 1
        fi
    fi
}

# Main script execution
check_git_installed
update_repo "$1"
delete_installer
