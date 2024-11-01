#!/bin/bash

### E-MAIL Settings ###
EM_MAX_RETRY=3                                        # How often should I retry to send a message if something goes wrong?
SMTP_SERVER='smtp.deinserver.com'                     # SMTP-Server-Adresse
SMTP_USER='dein-email@deinserver.com'                 # E-Mail Absender
SMTP_PASS='DEIN-SMTP-PASSWORD'                         # Passwort für den SMTP-Server
EMAIL_FROM='dein-email@deinserver.com'                # Absender E-Mail-Adresse
EMAIL_TO='empfaenger-email@beispiel.com'              # Empfänger E-Mail-Adresse
EMAIL_SUBJECT='Benachrichtigung über Systemupdates'    # Betreff der E-Mail
BENACHRICHTIGUNG='Updates auf dem Server ausgeführt'   # Your Text-Message if not changed to send logfile
