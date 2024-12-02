#!/bin/bash

# This File just downloads the Repo via Git

# Farben für Output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Repository-URL
REPO_URL="https://github.com/SubleXBle/Debian-Updater.git"

# Standard-Zielpfad
DEFAULT_PATH="/opt/Debian-Updater"

# Funktion zum Abrufen des Zielpfades vom Benutzer
get_target_path() {
    # Vorschlag für den Pfad
    echo -e "${BLUE}Möchtest du das Repository in den Pfad ${YELLOW} '$DEFAULT_PATH' ${NORMAL} herunterladen? ${YELLOW} (j/n): ${NORMAL}"
    read -p "(Drücke 'j' für den vorgeschlagenen Pfad oder 'n' für einen anderen Pfad): " RESPONSE

    if [[ "$RESPONSE" =~ ^[Jj]$ ]]; then
        TARGET_DIR="$DEFAULT_PATH"
    else
        read -p "Gib den Zielpfad ein, in den das Repository heruntergeladen werden soll: " TARGET_DIR
        # Überprüfen, ob der Pfad gültig ist
        if [ -z "$TARGET_DIR" ]; then
            echo -e "${RED}Fehler: Kein Pfad angegeben. Das Skript wird beendet.${NORMAL}"
            exit 1
        fi
    fi

    # Überprüfen, ob der Pfad existiert
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}Der Pfad existiert nicht. Er wird nun erstellt.${NORMAL}"
        mkdir -p "$TARGET_DIR"
    fi
}

# Zielpfad vom Benutzer abfragen
get_target_path

# Überprüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    echo -e "${RED}Fehler: Git ist nicht installiert. Bitte installiere Git und versuche es erneut.${NORMAL}"
    exit 1
fi

# Wechseln zum Zielverzeichnis
cd "$TARGET_DIR" || exit

# Überprüfen, ob das Verzeichnis bereits ein Git-Repository ist
if [ -d ".git" ]; then
    echo -e "${BLUE}Repository ist bereits vorhanden. Repository wird mit 'git pull' aktualisiert...${NORMAL}"
    git pull origin main
else
    echo -e "${YELLOW}Repository existiert nicht. Repository wird nun von GitHub geklont...${NORMAL}"
    git clone "$REPO_URL" "$TARGET_DIR"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Repository erfolgreich geklont.${NORMAL}"
    else
        echo -e "${RED}Fehler beim Klonen des Repositories.${NORMAL}"
        exit 1
    fi
fi

# Berechtigungen für die Dateien setzen
chmod +x "$TARGET_DIR/Debian-Updater.sh"
chmod +x "$TARGET_DIR/Updater-Update.sh"