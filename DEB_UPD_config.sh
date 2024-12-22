### USER VARIABLES ###
#
## Language selection
UV_LNG=EN                                       # Set language to English (EN), German (DE), or Spanish (SP)
#
## Updater Modes
UV_UpgradeMode=false                            # false runs apt-get upgrade -y / true runs apt-get dist-upgrade -y
UV_AutoremoveMode=false                         # false performs a --purge / true performs a "remove"
#
## Logging Level
UV_LOG=quiet                                    # Set logging level (quiet [-qq] / medium [-q] / all [no output option])
#
## Logfile handling
LOGFILE="/var/log/Updater.log"                  # Change if needed: e.g., /home/$USER/Updater.log (provide path)
UV_KEEP_LOG=false                               # Keep the logfile always (true / false). If true, log rotation happens
KILL_OLD_LOGS=false                             # Should old logs also be deleted when logfile is deleted (Log rotation)? (Deletes ALL old logs from this script)
LOGFILE_MAX_AGE=30                              # Delete old logfiles after 30 days
#
## Notification Types
UV_PUSHOVER=false                               # Use Pushover notifications: Make adjustments in PO_config.sh!
UV_TELEGRAM=false                               # Send Telegram messages
UV_GOTIFY=false                                 # Use Gotify for notifications
UV_DISCORD=false                                # Send Discord messages
UV_EMAIL=false                                  # Send Email notifications
UV_TEAMS=false                                  # Send MS-Teams messages
#
## Notification Options
UV_LOG2MSG=false                                # Should the logfile be sent via the selected notification method?
UV_NotifyOnlyOnError=false                      # Send notification only in case of an error
#UV_NotifyOrLog=false                            # If more than one notification method, choose whether the logfile should be sent with each notification
#
## RK-Hunter Options
UV_RKHUNTER=false                               # Should RKHunter be checked to update definitions and perform a property update?
UV_RKH_CHECK=false                              # Should RKHunter immediately perform a rootkit check?
#
# Nextcloud Updates
UV_NC_APP_Update=false                          # If true, the script will also run app updates for Nextcloud
UV_NC_OCC_PATH="/path/to/your/Nextcloud"        # Path to Nextcloud Installation
#
# MediaWiki Update
UV_MW_Update=false
UV_MW_PATH="/path/to/Mediawiki"
