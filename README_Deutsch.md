# Debian-Updater
+ Version: 0.7
+ Autor: SubleXBle
+ Repository: [GitHub: SubleXBle](https://github.com/SubleXBle/Debian-Updater)

## Beschreibung
Das Debian-Updater Script automatisiert die Aktualisierung eines Debian-basierten Systems. (Debian Ubuntu Kali Mint RaspberryOS usw.) Es prüft, ob Root-Rechte vorhanden sind, aktualisiert Paketquellen und installierte Pakete, entfernt auf Wunsch unnötige Pakete und überprüft das System optional auf Rootkits. Zusätzlich bietet es die Möglichkeit, Benachrichtigungen oder das Logfile über Pushover, Telegram oder Gotify zu versenden oder Logfiles via Logrotation längerfristig nachlesen zu können.

Das Script eignet sich durch einen --silent Modus sowie seine Fehlerbehandlung und Robustheit für die Ausführung als Cronjob.
Die Vielzahl an Logging-Optionen ermöglicht nahezu jedes Log-Setting. (Logrotation, Nur im Fehlerfall, Nur X Tage aufheben, kein Logging, Versenden von Logs, uvm)

## Funktionen
+ Systemaktualisierung: Aktualisiert Paketquellen (apt-get update), installiert verfügbare Updates (apt-get upgrade) und entfernt überflüssige Pakete (apt-get autoremove).
+ Protokollierung: Alle Aktivitäten werden in ein Logfile geschrieben, das optional gespeichert versendet oder gelöscht werden kann. Es wurden einige Logfile Funktionen implementiert um jeden Geschmack im Logfile-Handling treffen zu können. Diese sind über das Konfigurationsfile (DEB_UPD_config.sh) steuerbar.
+ Logrotation: Wenn das Logfile behalten wird, gibt es eine tägliche logfile Roatation oder automatische Löschung nach X Tagen.
+ Wahlweise Benachrichtigungen nur im Fehlerfall
+ Benachrichtigungen sowie das Logfile können über eine Vielzahl an Diensten versendet werden:
    + e-Mail ([SMTP](https://de.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol)) via Curl
    + Pushover ([https://pushover.net/](https://pushover.net/)) ([API](https://de.wikipedia.org/wiki/Wikipedia:Technik/Datenbank/API))-Call via CURL
    + Telegram ([https://web.telegram.org](https://web.telegram.org)) ([API](https://de.wikipedia.org/wiki/Wikipedia:Technik/Datenbank/API))-Call via CURL
    + Gotify ([https://gotify.net/](https://gotify.net/)) ([API](https://de.wikipedia.org/wiki/Wikipedia:Technik/Datenbank/API))-Call via CURL
    + Discord ([https://discord.com/](https://discord.com/)) ([Webhook](https://de.wikipedia.org/wiki/Webhooks)) via Curl
    + MS-Teams ([Webhook](https://de.wikipedia.org/wiki/Webhooks)) via Curl
+ Laufzeiterfassung: Das Skript misst und protokolliert die Gesamtlaufzeit.
+ Silent-Mode: Möglichkeit, die Konsolenausgabe zu unterdrücken, um das Skript z.B. in Cronjobs auszuführen.
+ Optionale RKHunter aktualisierung und/oder Überprüfung: Führt eine Rootkit-Prüfung durch und aktualisiert RKHunter, falls es installiert und aktiviert ist.

## Verwendung
./Debian-Updater.sh [-OPTION1 -OPTION2 usw]

### Optionen
+ -h, --help : Zeigt eine Hilfeseite mit den verfügbaren Optionen an.
+ -s, --silent : Unterdrückt die Konsolenausgabe, Logfile wird weiterhin erstellt.
+ -o, --onlyupdate : Führt nur die Aktualisierung der Paketquellen durch (apt-get update), ohne die Pakete zu aktualisieren.
+ -n, --no-autoremove : Es wird kein Autoremove ausgeführt
+ -l, --license : Die Lizenz wird angezeigt

## Übersichtliche Ausgabe
Die Ausgabe des Scipts (wenn nicht im --silent Modus als Cronjob) ist übersichtlich gestaltet
Das Logfile ist leicht lesbar, bei mehreren Runs die in einem Log landen, wird eine Trennzeile sowie Datum und Uhrzeit eingefügt. Zusätzlich gibt es eine Tägliche Logrotation.
An der Ausgabe in Englisch wird gerade gearbeitet, diese ist bereits über das Config File (DEB_UPD_config.sh) und die Variable $UV_LNG einstellbar.

## Konfiguration

### Config File (DEB_UPD_config.sh)
Alle Optionen können über ein config File im Hauptordner eingestellt werden.
Das config File ist in deutsch und englisch vorhanden, dass es für Benutzer einfacher ist, die richtigen Einstellungen vorzunehmen

Um das Englische Konfigurationsfile zu verwenden muss die DEB_UPD_config.sh.ENGLISCH in DEB_UPD_config.sh umbenannt werden (mv DEB_UPD_config.sh.ENGLISCH DEB_UPD_config.sh)

### Config Files für Benachrichtigungen
Für jede Versandart ist ein eigenes Config File im Ordner NotificationConfiguration vorhanden um die Verbindung mit dem jeweiligen Dienst (User, Passwd usw) vorzunehmen

## Vorraussetzungen
+ Ein [Debian](https://www.debian.org)-basiertes System. ([Debian](https://www.debian.org) / [Raspberry Pi OS](https://www.raspberrypi.com/software/) / [Ubuntu](https://ubuntu.com/) / [Linux Mint](https://linuxmint.com/) / [Kali Linux](https://www.kali.org/) : [Wikipedia-Liste Debian-Derivate](https://de.wikipedia.org/wiki/Liste_von_Linux-Distributionen#Debian-Derivate))
+ Hauptscript (Debian-Updater.sh) muss ausführbar gemacht werden (chmod +x Debian-Updater.sh)
+ Root-Rechte.
+ Optional : RKHunter (https://rkhunter.sourceforge.net/)
    + Wenn RK-Hunter auf dem System installiert ist, kann es gleich mitaktualisiert werden
    + Bei installiertem RK-Hunter kann nach der aktualisierung auch gleich ein --check ausgeführt werden
+ Für Benachrichtigungen muss "curl" (https://curl.se/) installiert sein

## Versionsbeschreibung
+ Ausgaben verschönert (RK-Hunter)
+ Loglevel eingeführt (quiet / medium / all) - Wird in DEB_UPD_config.sh gesetzt (bei Update Upgrade und Autoremove wirksam)

## Lizenz
+ GNU General Public License v3.0
+ Dieses Skript ist Open Source und kann frei verwendet und angepasst werden.
---------------------------------------------------------------------------------------
## Weiterentwicklung
laufende Aktualisierungen und Verbesserungen

+ Da ich das Script selbst für meine Systeme nutze kommen sicher noch Erweiterungen (wie z.B.: bereits derzeit RKHunter)
+ Eventuell einen Universal Updater daraus machen, der viele/alle Linux Distributionen unterstützt
---------------------------------------------------------------------------------------

## /fun
### Chat-GPT sagt:
#### Dieses Bash-Skript implementiert ein vollständiges System zur Verwaltung von Systemaktualisierungen, Benachrichtigungen und Logdateien von Debian Systemen.

Diese modulare und flexible Struktur mit konfigurierbaren Schaltern und einer detaillierten Logik für die Ausführung von Updates und Benachrichtigungen macht das Skript besonders geeignet für produktive Umgebungen. Durch die Möglichkeit, Systemaktualisierungen automatisiert durchzuführen und sofortige Benachrichtigungen zu erhalten, können Administratoren sicherstellen, dass ihre Systeme stets aktuell und sicher sind.
