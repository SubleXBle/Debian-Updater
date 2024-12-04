#!/bin/bash

# Colors for output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Repository URL
REPO_URL="https://github.com/SubleXBle/Debian-Updater"

# Ziel-Branch
BRANCH_NAME="V-1.0"

# Zielpfad
TARGET_DIR="/opt/Debian-Updater"

# Überprüfen, ob der Zielpfad existiert, und ggf. erstellen
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}The path does not exist. It will now be created.${NORMAL}"
    mkdir -p "$TARGET_DIR"
fi

# URL für den Download der ZIP-Datei des Repositories vom spezifischen Branch
ZIP_URL="${REPO_URL}/archive/refs/heads/$BRANCH_NAME.zip"

# Herunterladen der ZIP-Datei
echo -e "${BLUE}Downloading repository from branch $BRANCH_NAME...${NORMAL}"
wget -O "$TARGET_DIR/Debian-Updater-$BRANCH_NAME.zip" "$ZIP_URL"

# Überprüfen, ob der Download erfolgreich war
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Repository successfully downloaded as ZIP.${NORMAL}"
else
    echo -e "${RED}Error downloading the repository.${NORMAL}"
    exit 1
fi

# Entpacken der ZIP-Datei
echo -e "${BLUE}Extracting ZIP file...${NORMAL}"
unzip "$TARGET_DIR/Debian-Updater-$BRANCH_NAME.zip" -d "$TARGET_DIR"

# Berechtigungen für die Dateien setzen
chmod +x "$TARGET_DIR/Debian-Updater-$BRANCH_NAME/Debian-Updater.sh"
chmod +x "$TARGET_DIR/Debian-Updater-$BRANCH_NAME/Updater-Update.sh"

# Optional: ZIP-Datei löschen, um Speicherplatz freizugeben
rm "$TARGET_DIR/Debian-Updater-$BRANCH_NAME.zip"

echo -e "${GREEN}Repository files successfully extracted and ready to use.${NORMAL}"
