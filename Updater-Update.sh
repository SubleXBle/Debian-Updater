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

        # Repository aktualisieren (Fetch ohne Pull)
        git fetch origin "$BRANCH_NAME"

        # Liste der geänderten Dateien erstellen
        CHANGED_FILES=$(git diff --name-only HEAD..origin/"$BRANCH_NAME")
        
        if [ -n "$CHANGED_FILES" ]; then
            echo -e "${GREEN}Die folgenden Dateien wurden im Repository geändert:${NORMAL}"
            echo "$CHANGED_FILES"

            # Änderungen anwenden (geänderte Dateien direkt herunterladen)
            for FILE in $CHANGED_FILES; do
                echo -e "${YELLOW}Aktualisiere Datei: $FILE${NORMAL}"
                
                # Datei direkt aus dem Remote-Repository herunterladen
                curl -s -o "$FILE" \
                    "https://raw.githubusercontent.com/SubleXBle/Debian-Updater/$BRANCH_NAME/$FILE"

                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}Datei '$FILE' erfolgreich heruntergeladen.${NORMAL}"
                else
                    echo -e "${RED}Fehler beim Herunterladen der Datei '$FILE'.${NORMAL}"
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
            echo -e "${YELLOW}Keine Änderungen im Repository gefunden.${NORMAL}"
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

# Installer löschen, wenn vorhanden
INSTALLER_FILE="$TARGET_DIR/Installer.sh"

# Überprüfen, ob die Datei Installer.sh existiert
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
