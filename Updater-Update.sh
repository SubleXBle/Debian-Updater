#!/bin/bash

# Farben für Output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Der TARGET_DIR Pfad wird auf das aktuelle Verzeichnis gesetzt
TARGET_DIR="$(pwd)"  # Aktueller Pfad des Skripts

# Überprüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    echo -e "${RED}Fehler: Git ist nicht installiert. Bitte installiere Git und versuche es erneut.${NORMAL}"
    exit 1
fi

echo -e "$NORMAL"
echo "Updater Repository wird aktualisiert..."

# Überprüfen, ob das Zielverzeichnis existiert und ein Git-Repository ist
if [ -d "$TARGET_DIR" ]; then
    if [ -d "$TARGET_DIR/.git" ]; then
        echo "Das Verzeichnis $TARGET_DIR ist ein Git-Repository."
        cd "$TARGET_DIR" || exit
        
        # Ermittelt den Standard-Branch des Repositories
        BRANCH_NAME=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
        if [ -z "$BRANCH_NAME" ]; then
            echo -e "${RED}Fehler: Der Standard-Branch konnte nicht ermittelt werden.${NORMAL}"
            exit 1
        fi

        # Zeigt den Branch an, der gepullt wird
        echo -e "${BLUE}Pulle Branch: $BRANCH_NAME${NORMAL}"

        # Repository aktualisieren
        echo "Aktualisiere Repository mit 'git pull origin $BRANCH_NAME'..."
        if git pull origin "$BRANCH_NAME"; then
            echo -e "${GREEN}Repository erfolgreich aktualisiert.${NORMAL}"
        else
            echo -e "${RED}Fehler beim Aktualisieren des Repositories.${NORMAL}"
            exit 1
        fi
    else
        echo -e "${YELLOW}Das Verzeichnis $TARGET_DIR existiert, ist aber kein Git-Repository.${NORMAL}"
        echo "Lösche das Verzeichnis und klone das Repository neu."
        rm -rf "$TARGET_DIR"
        if git clone "https://github.com/SubleXBle/Debian-Updater.git" "$TARGET_DIR"; then
            echo -e "${GREEN}Repository erfolgreich geklont.${NORMAL}"
        else
            echo -e "${RED}Fehler beim Klonen des Repositories.${NORMAL}"
            exit 1
        fi
    fi
else
    echo "Das Verzeichnis $TARGET_DIR existiert nicht."
    echo "Klonen des Repositorys von https://github.com/SubleXBle/Debian-Updater.git nach $TARGET_DIR..."
    if git clone "https://github.com/SubleXBle/Debian-Updater.git" "$TARGET_DIR"; then
        echo -e "${GREEN}Repository erfolgreich geklont.${NORMAL}"
    else
        echo -e "${RED}Fehler beim Klonen des Repositories.${NORMAL}"
        exit 1
    fi
fi

# Dateien ausführbar machen
echo "Mache die Dateien 'Updater-Update.sh' und 'Debian-Updater.sh' ausführbar..."
chmod +x "$TARGET_DIR/Updater-Update.sh" "$TARGET_DIR/Debian-Updater.sh"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Dateien wurden erfolgreich ausführbar gemacht.${NORMAL}"
else
    echo -e "${RED}Fehler beim Setzen der Ausführungsrechte auf die Dateien.${NORMAL}"
    exit 1
fi
