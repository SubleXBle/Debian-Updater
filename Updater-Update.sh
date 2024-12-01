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
        git pull origin "$BRANCH_NAME"

        # Überprüfen, ob Änderungen vorgenommen wurden
        if [ $? -eq 0 ] && [ "$(git status --porcelain)" != "" ]; then
            echo -e "${GREEN}Repository erfolgreich aktualisiert. Es wurden Änderungen vorgenommen.${NORMAL}"

            # Liste der lokal geänderten Dateien
            CHANGED_FILES=$(git status --porcelain | grep '^[M]' | awk '{print $2}')

            # Für jede geänderte Datei nachfragen, wie weiter verfahren werden soll
            for FILE in $CHANGED_FILES; do
                echo -e "${YELLOW}Die Datei '$FILE' wurde lokal geändert.${NORMAL}"
                echo "Wie soll mit dieser Datei verfahren werden?"
                echo "1) Datei mit Neuerungen aus Repository überschreiben"
                echo "2) Backup von betroffener Datei erstellen (.BAK) und Datei danach überschreiben"
                echo "3) Diese Datei überspringen"
                echo "4) Das Backup abbrechen"
                read -p "Wähle eine Option (1-4): " option
                
                case $option in
                    1)
                        echo "Die Datei '$FILE' wird mit den Neuerungen aus dem Repository überschrieben."
                        git checkout -- "$FILE"
                        ;;
                    2)
                        echo "Erstelle Backup der Datei '$FILE' als '$FILE.BAK'."
                        cp "$FILE" "$FILE.BAK"
                        git checkout -- "$FILE"
                        ;;
                    3)
                        echo "Die Datei '$FILE' wird übersprungen."
                        ;;
                    4)
                        echo "Backup und Änderungen werden abgebrochen. Kein weiteres Vorgehen."
                        exit 1
                        ;;
                    *)
                        echo -e "${RED}Ungültige Option. Die Datei '$FILE' wird übersprungen.${NORMAL}"
                        ;;
                esac
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
            echo -e "${YELLOW}Es wurden keine Änderungen im Repository vorgenommen.${NORMAL}"
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
