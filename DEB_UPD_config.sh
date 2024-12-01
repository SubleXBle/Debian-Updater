### USERVARIABLEN ###
#
## Sprachwahl
UV_LNG=DE                                       # Sprache auf Englisch (EN) oder Deutsch (DE) oder Spanisch (SP) umstellen
#
## Updater-Modes
UV_UpgradeMode=false                            # false führt apt-get upgrade -y -a durch / true führt apt-get dist-upgrade -y durch
UV_AutoremoveMode=false                         # false führt ein --purge durch / true führt ein "remove" durch
#
## LoggingLevel
UV_LOG=quiet                                    # Loggingstärke angeben (quiet [-qq] / medium [-q] / all [keine output option])
#
## Logfilebehandlung
LOGFILE="/var/log/Updater.log"                  # bei Bedarf ändern : z.B: /home/$USER/Updater.log (Pfad angeben)
UV_KEEP_LOG=false                               # Logfile immer behalten (true / false) Wenn true findet Logrotation statt
KILL_OLD_LOGS=false                             # Bei Logfile löschung auch alte Logs (Logrotation) löschen? (Löscht ALLE alten Logfiles von diesem Script)
LOGFILE_MAX_AGE=30                              # Löscht alte Logfiles nach 30 Tagen
#
## Benachrichtigungs Arten
UV_PUSHOVER=false                               # Pushover Benachrichtigungen verwenden : Anpassungen im File PO_config.sh vornehmen!
UV_TELEGRAM=false                               # Telegram Nachricht versenden
UV_GOTIFY=false                                 # Gotify für Benachrichtigungen verwenden
UV_DISCORD=false                                # Discord Nachricht versenden
UV_EMAIL=false                                  # Email Nachricht versenden
UV_TEAMS=false                                  # MS-Teams Nachricht versenden
#
## Benachrichtigungs Optionen
UV_LOG2MSG=false                                # Soll das Logfile über die gewünschte Benachrichtigungsart versendet werden?
UV_NotifyOnlyOnError=false                      # Die Benachrichtigung soll nur im Fehlerfall versendet werden
#UV_NotifyOrLog=false                            # Wenn mehr als eine Benachrichtigungsart, kann für jede Benachrichtigungsart gewählt werden, ob das Logfile mitgesendet werden soll
#
## RK-Hunter Optionen
UV_RKHUNTER=false                               # Soll auf RKHunter geprüft werden um die Definitionen updaten zu können und ein Property Update auszuführen?
UV_RKH_CHECK=false                              # Soll RK-Hunter gleich einen Check auf Rootkits durchführen?
#
# Nextcloud Updates
UV_NC_APP_Update=false                          # Wenn auf true gesetzt, wird das Script ebenfalls App-Updates für Nextcloud ausführen
UV_NC_OCC_PATH="/path/to/your/Nextcloud"        # Path to Nextcloud Installation
