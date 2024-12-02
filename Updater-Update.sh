#!/bin/bash

# Farben für Output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Der TARGET_DIR Pfad wird auf das aktuelle Verzeichnis gesetzt
TARGET_DIR="$(pwd)"

# Überprüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    echo -e "${RED}Fehler: Git ist nicht installiert. Bitte installiere Git und versuche es erneut.${NORMAL}"
    exit 1
fi

echo -e "$NORMAL"
echo "Updater Repository wird aktualisiert..."

# Überprüfen, ob das Zielverzeichnis existiert und ein Git-Repository ist
if [ -d "$TARGET_DIR" ] && [ -d "$TARGET_DIR/.git" ]; then
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

    # Repository aktualisieren (nur fetch)
    echo "Hole Änderungen aus dem Repository mit 'git fetch origin $BRANCH_NAME'..."
    git fetch origin "$BRANCH_NAME"
    
    # Dateien identifizieren, die sich im Repository geändert haben
    CHANGED_FILES=$(git diff --name-only origin/"$BRANCH_NAME")

    if [ -z "$CHANGED_FILES" ]; then
        echo -e "${YELLOW}Es wurden keine Änderungen im Repository gefunden.${NORMAL}"
        exit 0
    fi

    # Benutzer über Änderungen informieren und Entscheidungen einholen
    for FILE in $CHANGED_FILES; do
        if [ -f "$FILE" ]; then
            echo -e "${YELLOW}Die Datei '$FILE' wurde lokal geändert.${NORMAL}"
            echo "Wie soll mit dieser Datei verfahren werden?"
            echo "1) Backup der Datei erstellen (.BAK) und Datei aktualisieren"
            echo "2) Datei ohne Backup aktualisieren"
            echo "3) Datei überspringen"
            echo "4) Abbrechen"
            read -p "Wähle eine Option (1-4): " option

            case $option in
                1)
                    echo "Erstelle Backup der Datei '$FILE' als '$FILE.BAK'."
                    cp "$FILE" "$FILE.BAK"
                    echo "Lade aktualisierte Version der Datei '$FILE'."
                    git checkout origin/"$BRANCH_NAME" -- "$FILE"
                    ;;
                2)
                    echo "Lade aktualisierte Version der Datei '$FILE' ohne Backup."
                    git checkout origin/"$BRANCH_NAME" -- "$FILE"
                    ;;
                3)
                    echo "Überspringe die Datei '$FILE'."
                    ;;
                4)
                    echo "Abbruch des Skripts durch den Benutzer."
                    exit 1
                    ;;
                *)
                    echo -e "${RED}Ungültige Option. Die Datei '$FILE' wird übersprungen.${NORMAL}"
                    ;;
            esac
        else
            echo -e "${YELLOW}Die Datei '$FILE' existiert nicht lokal. Sie wird heruntergeladen.${NORMAL}"
            git checkout origin/"$BRANCH_NAME" -- "$FILE"
        fi
    done

    # Dateien ausführbar machen
    echo "Mache die Dateien 'Updater-Update.sh' und 'Debian-Updater.sh' ausführbar..."
    chmod +x "$TARGET_DIR/Updater-Update.sh" "$TARGET_DIR/Debian-Updater.sh"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Dateien wurden erfolgreich ausführbar gemacht.${NORMAL}"
    else
        echo -e "${RED}Fehler beim Setzen der Ausführungsrechte auf die Dateien.${NORMAL}"
        exit 1
    fi
else
    echo "Das Verzeichnis $TARGET_DIR ist kein Git-Repository oder existiert nicht."
    echo "Klonen des Repositorys von https://github.com/SubleXBle/Debian-Updater.git nach $TARGET_DIR..."
    if git clone "https://github.com/SubleXBle/Debian-Updater.git" "$TARGET_DIR"; then
        echo -e "${GREEN}Repository erfolgreich geklont.${NORMAL}"
    else
        echo -e "${RED}Fehler beim Klonen des Repositories.${NORMAL}"
        exit 1
    fi
fi

# Installer löschen, wenn vorhanden
INSTALLER_FILE="$TARGET_DIR/Installer.sh"

if [ -f "$INSTALLER_FILE" ]; then
    echo -e "${YELLOW}Die Datei 'Installer.sh' wird nun gelöscht.${NORMAL}"
    rm -f "$INSTALLER_FILE"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Die Datei wurde erfolgreich gelöscht.${NORMAL}"
    else
        echo -e "${RED}Fehler beim Löschen der Datei.${NORMAL}"
        exit 1
    fi
fi
