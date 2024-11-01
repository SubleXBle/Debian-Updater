#!/bin/bash

F_PUSHOVER() {
    if [ "$UV_PUSHOVER" = true ]; then
        log_message -n $NORMAL "Sende PushOver Nachricht \t \t \t "
        RETRY_COUNT=0
        while [ "$RETRY_COUNT" -lt "$PO_MAX_RETRY" ]; do
        CURL_OUTPUT=$(curl \
                --form-string "token=$PO_TOKEN" \
                --form-string "user=$PO_USER" \
                --form-string "title=$PO_TITLE" \
                --form-string "message=$BENACHRICHTIGUNG" \
                --form-string "url_title=$PO_LINKTITLE" \
                --form-string "url=$PO_LINK" \
                --form-string "priority=$PO_PRIO" \
                https://api.pushover.net/1/messages.json 2>&1)
                
                if [ $? -eq 0 ]; then
                    log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
                    log_message ""
                    return 0
                    echo "Pushover Nachricht erfolgreich versendet">>$LOGFILE
                else
                    ((RETRY_COUNT++))
                    FEHLER=5
                    log_message -n -e "$NORMAL[$RED✗$NORMAL]"
                    log_message "Fehler"
                    log_message -n -e "Versuch $RETRY_COUNT/$TG_MAX_RETRY: $CURL_OUTPUT \t \t \t"
                    log_message -e ""
                    sleep 2
                fi
            done
            log_message -e "$NORMAL[$RED✗$NORMAL] $TG_MAX_RETRY Versuche"
            echo "======== PUSHOVER NICHT GESENDET ===========">>$LOGFILE
        fi
}

F_TELEGRAM() {
    if [ "$UV_TELEGRAM" = true ]; then
        log_message -n "$NORMAL" "Sende Telegram Nachricht \t \t \t "
        RETRY_COUNT=0
        while [ "$RETRY_COUNT" -lt "$TG_MAX_RETRY" ]; do
            CURL_OUTPUT=$(curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID&text=$BENACHRICHTIGUNG")
            if [ $? -eq 0 ]; then
                log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
                log_message ""
                echo "Telegram Nachricht erfolgreich versendet" >> "$LOGFILE"
                return 0
            else
                ((RETRY_COUNT++))
                FEHLER=5
                log_message -n -e "$NORMAL[$RED✗$NORMAL]"
                log_message "Fehler"
                log_message -n -e "Versuch $RETRY_COUNT/$TG_MAX_RETRY: $CURL_OUTPUT \t \t \t"
                log_message -e ""
                sleep 2
            fi
        done
        log_message -e "$NORMAL[$RED✗$NORMAL] $TG_MAX_RETRY Versuche"
        echo "======== TELEGRAM NICHT GESENDET ===========">>$LOGFILE
    fi
}

# Falls gewollt Gotify Nachricht versenden - Anpassungen im File PO_config.sh vornehmen
send_gotify_message() {
    if [ "$UV_GOTIFY" = true ]; then
        curl -s -X POST "$GOTIFY_URL" \
        -F "title=$GO_TITLE" \
        -F "message=$BENACHRICHTIGUNG" \
        -F "priority=$GO_PRIO" \
        -H "Authorization: Bearer $GOTIFY_TOKEN" > /dev/null
        # Überprüfen, ob die Nachricht erfolgreich gesendet wurde
            if [ $? -eq 0 ]; then
                log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
                log_message ""
                echo "GOTIFY Nachricht erfolgreich versendet" >> "$LOGFILE"
            else
                log_message -n -e "$NORMAL[$RED✗$NORMAL]"
                log_message "Fehler"
                echo "======== GOTIFY NICHT GESENDET ===========">>$LOGFILE
            fi
    fi
}

F_EMAIL() {
    if [ "$UV_EMAIL" = true ]; then
        log_message -n "$NORMAL Sende E-Mail \t \t \t \t \t "
        RETRY_COUNT=0
        while [ "$RETRY_COUNT" -lt "$EM_MAX_RETRY" ]; do
            CURL_OUTPUT=$(curl \
                --url "smtp://$SMTP_SERVER:587" \
                --user "$SMTP_USER:$SMTP_PASS" \
                --mail-from "$EMAIL_FROM" \
                --mail-rcpt "$EMAIL_TO" \
                --upload-file <(echo -e "Subject: $EMAIL_SUBJECT\n\n$BENACHRICHTIGUNG") \
                --ssl-reqd 2>&1)

            if [ $? -eq 0 ]; then
                log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
                log_message ""
                echo "E-Mail erfolgreich versendet" >> "$LOGFILE"
                return 0
            else
                ((RETRY_COUNT++))
                FEHLER=5
                log_message -n -e "$NORMAL[$RED✗$NORMAL]"
                log_message "Fehler"
                log_message -n -e "Versuch $RETRY_COUNT/$EM_MAX_RETRY: $CURL_OUTPUT \t \t \t"
                log_message -e ""
                sleep 2
            fi
        done
        log_message -e "$NORMAL[$RED✗$NORMAL] $EM_MAX_RETRY Versuche"
        echo "======== E-MAIL NICHT GESENDET ===========">>$LOGFILE
    fi
}

F_DISCORD() {
    if [ "$UV_DISCORD" = true ]; then
        log_message -n "$NORMAL Sende Discord Nachricht \t \t \t "
        RETRY_COUNT=0
        while [ "$RETRY_COUNT" -lt "$DC_MAX_RETRY" ]; do
            CURL_OUTPUT=$(curl \
                -H "Content-Type: application/json" \
                -X POST \
                -d "{\"content\": \"$BENACHRICHTIGUNG\"}" \
                "$DISCORD_WEBHOOK_URL" 2>&1)

            if [ $? -eq 0 ]; then
                log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
                log_message ""
                echo "Discord Nachricht erfolgreich versendet" >> "$LOGFILE"
                return 0
            else
                ((RETRY_COUNT++))
                FEHLER=5
                log_message -n -e "$NORMAL[$RED✗$NORMAL]"
                log_message "Fehler"
                log_message -n -e "Versuch $RETRY_COUNT/$DC_MAX_RETRY: $CURL_OUTPUT \t \t \t"
                log_message -e ""
                sleep 2
            fi
        done
        log_message -e "$NORMAL[$RED✗$NORMAL] $DC_MAX_RETRY Versuche"
        echo "======== DISCORD NICHT GESENDET ===========">>$LOGFILE
    fi
}

F_TEAMS() {
    if [ "$UV_TEAMS" = true ]; then
        log_message -n "$NORMAL Sende Teams Nachricht \t \t \t "
        RETRY_COUNT=0
        while [ "$RETRY_COUNT" -lt "$TEAMS_MAX_RETRY" ]; do
            CURL_OUTPUT=$(curl \
                -H "Content-Type: application/json" \
                -X POST \
                -d "{\"text\": \"$BENACHRICHTIGUNG\"}" \
                "$TEAMS_WEBHOOK_URL" 2>&1)

            if [ $? -eq 0 ]; then
                log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
                log_message ""
                echo "Microsoft Teams Nachricht erfolgreich versendet" >> "$LOGFILE"
                return 0
            else
                ((RETRY_COUNT++))
                FEHLER=5
                log_message -n -e "$NORMAL[$RED✗$NORMAL]"
                log_message "Fehler"
                log_message -n -e "Versuch $RETRY_COUNT/$TEAMS_MAX_RETRY: $CURL_OUTPUT \t \t \t"
                log_message -e ""
                sleep 2
            fi
        done
        log_message -e "$NORMAL[$RED✗$NORMAL] $TEAMS_MAX_RETRY Versuche"
        echo "======== TEAMS NICHT GESENDET ===========">>$LOGFILE
    fi
}
