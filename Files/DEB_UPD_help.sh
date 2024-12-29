#!/bin/bash

F_HELP() {
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Hilfe für Debian-Updater Skript" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e $BLUE "Script by SubleXBle (https://github.com/SubleXBle)" $NORMAL
    echo
    echo -e $TXTBOLD "Dieses Skript verwaltet Systemaktualisierungen und Benachrichtigungen." $NORMAL
    echo
    echo -e $YELLOW $TXTBOLD "Verfügbare Optionen:" $NORMAL
    echo "  -s, --silent                Führe das Skript im Silent-Modus aus, ohne Ausgaben auf der Konsole anzuzeigen."
    echo "  -h, --help                  Zeigt diese Hilfe an."
    echo "  -o, --onlyupdate            Aktualisiert nur die Repositorys und zeigt verfügbare Updates an, ohne die Pakete zu aktualisieren."
    echo "  -n, --no-autoremove         Verhindert die automatische Entfernung nicht mehr benötigter Pakete nach dem Upgrade."
    echo "  -d, --dist-upgrade          führt das Upgrade einmalig als Dist-Upgrade aus."
    echo "  -tn, --test-notifications   zum testen der Notification Einstellungen."
    echo
    echo -e $BLUE "========================================"
    echo -e $YELLOW $TXTBOLD "Benutzer-Variablen (in DEB_UPD_config.sh):" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e "$TXTBOLD Einstellungen in DEB_UPD_config.sh" $NORMAL
    echo -e "Logfiles"
    echo -e "Logrotation"
    echo -e "Benachrichtigungen"
    echo -e "RK-Hunter"
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Funktionsweise:" $NORMAL
    echo -e $TXTBOLD "Das Skript führt die folgenden Schritte aus:" $NORMAL
    echo "1. Prüfen der Root-Rechte."
    echo "2. Aktualisieren der Repositorys."
    echo "3. Anzeigen von verfügbaren Updates."
    echo "4. Aktualisieren der Pakete."
    echo "5. Automatisches Entfernen nicht mehr benötigter Pakete (wenn nicht deaktiviert)."
    echo "6. Optional: Durchführung von Rootkit-Prüfungen."
    echo "7. Logfile-Verwaltung: Rotation und Löschen alter Logfiles."
    echo "8. Senden von Benachrichtigungen bei Fehlern oder erfolgreichem Abschluss (je nach Konfiguration)."
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Benutzung:" $NORMAL
    echo "Um das Skript auszuführen, verwenden Sie die folgenden Befehle:"
    echo "./Debian-Updater.sh [Optionen]"
    echo
    echo "z.B.: ./Debian-Updater -n -s (Führt kein Autoremove aus und wird im Silent Mode ausgeführt)"
    echo -e $BLUE "========================================" $NORMAL
}
