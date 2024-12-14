#!/bin/bash

### PUSHOVER VARIABLEN ###
PO_MAX_RETRY=3                                      # How often should I retry to send a message if something goes wrong?
PO_TOKEN='DEIN-PUSHOVER-APP-TOKEN'                  # welche App sendet (Application Token)
PO_USER='DEIN-PUSHOVER-USER-TOKEN'                  # Empfänger (User Key)
PO_TITLE='Updates auf Webserver'                    # Subject
BENACHRICHTIGUNG='Updates auf Webserver ausgeführt' # Your Text-Message if not changed to send logfile
PO_LINKTITLE=''                                     # Linktitel / Linkname
PO_LINK=''                                          # Link (URL)
PO_PRIO='0'                                         # Priorität (lowest: -2 / low: -1 / Normal: 0 / High: 1)
