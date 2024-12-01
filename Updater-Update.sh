#!/bin/bash

# Farben für Output
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[33m'
BLUE='\033[34m'

# Die lokale Zielvariable für den Pfad des Repositories
TARGET_DIR="/opt/Debian-Updater"  # Hier kannst du den Pfad anpassen

# Überprüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    echo -e "${RED}Fehler: Git ist nicht installiert. Bitte installiere Git und versuche es erneut.${NORMAL}"
    exit 1
fi

echo -e "$NORMAL"
echo "Updater Repository wird aktualisiert..."

# Standard-Branch definieren
BRANCH_NAME="main"  # Hier kannst du den Standard-Branch anpassen (z.B. "main" oder "master")

# Überprüfen, ob das Zielverzeichnis existiert und ein Git-Repository ist
if [ -d "$TARGET_DIR" ]; then
    if [ -d "$TARGET_DIR/.git" ]; then
        echo "Das Verzeichnis $TARGET_DIR ist ein Git-Repository."
        cd "$TARGET_DIR" || exit
        
        # Prüfen auf Konflikte in geänderten Dateien
        CHANGED_FILES=$(git diff --name-only)
        if [ -n "$CHANGED_FILES" ]; then
            echo -e "${YELLOW}Es wurden lokale Änderungen an folgenden Dateien festgestellt:${NORMAL}"
            echo "$CHANGED_FILES"
            for CONFLICT_FILE in $CHANGED_FILES; do
                echo -e "${YELLOW}Konflikt erkannt: Die Datei '$CONFLICT_FILE' wurde lokal geändert.${NORMAL}"
                echo "Wählen Sie aus, wie vorgegangen werden soll:"
                echo "1) Lokale Änderungen überschreiben"
                echo "2) Backup der lokalen Datei erstellen und überschreiben"
                echo "3) Diese Datei nicht pullen"
                echo "4) Update abbrechen"
                read -p "Option (1/2/3/4) für '$CONFLICT_FILE': " user_choice

                case $user_choice in
                    1)
                        echo "Lokale Änderungen an '$CONFLICT_FILE' werden überschrieben."
                        git checkout -- "$CONFLICT_FILE"
                        ;;
                    2)
                        echo "Backup der Datei '$CONFLICT_FILE' wird erstellt."
                        cp "$TARGET_DIR/$CONFLICT_FILE" "$TARGET_DIR/$CONFLICT_FILE.BAK"
                        echo "Backup unter '$CONFLICT_FILE.BAK' gespeichert."
                        git checkout -- "$CONFLICT_FILE"
                        ;;
                    3)
                        echo "Die Datei '$CONFLICT_FILE' wird bei diesem Pull nicht berücksichtigt."
                        # Die Datei von Git ignorieren
                        git update-index --assume-unchanged "$CONFLICT_FILE"
                        ;;
                    4)
                        echo "Update abgebrochen."
                        exit 0
                        ;;
                    *)
                        echo -e "${RED}Ungültige Auswahl. Abbruch.${NORMAL}"
                        exit 1
                        ;;
                esac
            done
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
