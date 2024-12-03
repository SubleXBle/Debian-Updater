# Debian-Updater ⚙️
+ Version: 1.0
+ Author: SubleXBle
+ Repository: [GitHub: SubleXBle](https://github.com/SubleXBle/Debian-Updater)
+ Available in English / German / Spain

## Description 📝
⚙️The Debian-Updater script automates the updating of a Debian-based system (Debian, Ubuntu, Kali, Mint, RaspberryOS, etc.).<br>
⚙️It checks for root privileges, updates package sources and installed packages, removes unnecessary packages upon request, and optionally checks the system for rootkits.<br>
⚙️Additionally, it offers the option to send notifications or the log file via Pushover, Gotify, e-Mail, Telegram, Discord or MS-Teams or to retain log files for the long term via log rotation.

⚙️The script is suitable for execution as a cron job due to its --silent mode, error handling, and robustness.<br>
⚙️The variety of logging options allows for nearly any log setting (log rotation, keep only in case of errors, keep only for X days, no logging, send logs, etc.).

## Installer and Update-Script ⚠️
Use the "Installer" for Initial Clone
```bash
wget https://raw.githubusercontent.com/SubleXBle/Debian-Updater/V-0.9/Installer.sh && chmod +x Installer.sh && ./Installer.sh
```
You will get asked for the Path : Use the full Path : eg "/opt/Debian-Updater" (standard-path)

then use the Updater for Updates of the Script
```bash
./Updater-Update.sh
```
set The Variables in DEB_UPD_config.sh

then run the Updater.
```bash
./Debian-Updater.sh
```
Or you set it up as a cronjob to run in silentmode and inform you when it has updated the system or when something went wrong doing updates.

## Important Files in this Repository ℹ️
+ Debian-Updater.sh (Main Script)
+ DEB_UPD_config.sh (Updater-Settings)
    + Default = English
    + Other Versions (German & Spain) are in the Repo (just rename them)
+ Folder Files (scriptparts)
+ Folder NotificationConfiguration (read the name)
+ Updater-Update.sh (yes, finally the updater for the updater)


## Features 🚀
+ System update: Updates package sources (apt-get update), installs available updates (apt-get upgrade), and removes unnecessary packages (apt-get autoremove).
    + You can set different modes for upgrade or autoremove in the config file (DEB_UPD_config.sh)
    + The config file is available in different languages for your convenience.
+ Logging: All activities are written to a log file that can be optionally saved, sent, or deleted. Some log file functions have been implemented to meet every preference in log file handling. These can be controlled via the configuration file (DEB_UPD_config.sh).
+ Log rotation: If the log file is retained, there is a daily log file rotation or automatic deletion after X days.
+ LogLevel: Change Loglevel between full, medium or quiet
+ Optional notifications only in case of errors.
+ Notifications and the log file can be sent via a variety of services:
    + Email SMTP via Curl
    + Pushover API Call via CURL
    + Telegram API Call via CURL
    + Gotify API Call via CURL
    + Discord Webhook via Curl
    + MS-Teams Webhook via Curl
+ Runtime tracking: The script measures and logs the total runtime.
+ Silent mode: Option to suppress console output, allowing the script to be run in cron jobs, for example.
+ Optional RKHunter update and/or check: Performs a rootkit check and updates RKHunter if it is installed and activated.
+ Has it's own pullscript - define the folder where it should be pulled to - then use this script to update the script when repo has changed)
+ Optional Nextcloud App update
+ Optional MediaWiki Installation update


## Usage 🖥️
./Debian-Updater.sh [-OPTION1 -OPTION2 etc.]

### Options 🛠️
+ -h, --help : Displays a help page with the available options.
+ -s, --silent : Suppresses console output; the log file is still created.
+ -o, --onlyupdate : Only updates the package sources (apt-get update) without updating the packages.
+ -n, --no-autoremove : No autoremove will be performed.
+ -l, --license : Displays the license.
+ -d, --dist-upgrade : Runs apt-get dist-upgrade only on this run (even if set to no in config)

## Clear Output 📋
The output of the script (when not in --silent mode as a cron job) is clearly designed. The log file is easy to read; for multiple runs that end up in one log, a separator line as well as the date and time are inserted. Additionally, there is a daily log rotation. An English output is currently being worked on; it can already be set via the config file (DEB_UPD_config.sh) and the variable $UV_LNG.

## Configuration 🛠️

### Config File (DEB_UPD_config.sh)
All options can be set via a config file in the main folder. The config file is available in both German and English to make it easier for users to make the right settings.

To use the English configuration file, the DEB_UPD_config.sh.ENGLISH must be renamed to DEB_UPD_config.sh (mv DEB_UPD_config.sh.ENGLISH DEB_UPD_config.sh).

### Config Files for Notifications
Each method of sending notifications has its own config file in the NotificationConfiguration folder to establish the connection with the respective service (user, password, etc.).

## Prerequisites ⚙️
+ A [Debian](https://www.debian.org)-based system. ([Debian](https://www.debian.org) / [Raspberry Pi OS](https://www.raspberrypi.com/software/) / [Ubuntu](https://ubuntu.com/) / [Linux Mint](https://linuxmint.com/) / [Kali Linux](https://www.kali.org/): [Wikipedia list of Debian derivatives](https://de.wikipedia.org/wiki/Liste_von_Linux-Distributionen#Debian-Derivate))
+ Main script (Debian-Updater.sh) must be made executable (chmod +x Debian-Updater.sh).
+ Root privileges.
+ Optional: RKHunter (https://rkhunter.sourceforge.net/)
    + If RKHunter is installed on the system, it can be updated simultaneously.
    + If RKHunter is installed, a --check can also be executed immediately after the update.
+ For notifications, "curl" (https://curl.se/) must be installed.

## Version Description 🚀
+ ✔️ Generel Bugfixes
+ ✔️ Language Bugs fixed
+ ✔️ Reworked Updater-Update.sh in order to take more consideration into settings already set by the user
+ ✔️ All non-translated Stuff set to english - so less german babble :)
+ ✔️ Set default-language to english

## Addins (Optional) ⬇️
+ RK-Hunter Property Updates & Checks
+ Updates for Nextcloud Apps
+ Updates for MediaWiki Installation

## License 📄
+ GNU General Public License v3.0
+ This script is open source and can be freely used and modified.
---------------------------------------------------------------------------------------

## Further Development 🛠️
Ongoing updates and improvements : since I use the script for my own systems, there will certainly be expansions.

---------------------------------------------------------------------------------------

## /fun 🤪
I am sorry, that some code is written in German - never thougt my updater gets this "big" (in terms of code - not fame)

### TL/TR
does the update thing for ya

