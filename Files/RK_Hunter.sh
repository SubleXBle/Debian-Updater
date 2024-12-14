#!/bin/bash
# Check for RK-Hunter to avoid false-positives after running apt upgrade
# When installed "rkhunter --update" and "rkhunter --propupd" will be executed
F_ROOTKIT() {
   log_message -n "$NORMAL $LV_CheckIfRKHunter: \t \t \t \t "
   if dpkg -l | grep rkhunter >>$LOGFILE; then
        log_message -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
        echo "$LV_RKHunterFound">>$LOGFILE
        V_ROOTKIT=true
        log_message -n -e "$NORMAL $LV_RKHunterUpd \t \t "
        rkhunter --update >>/dev/null
        rkhunter --propupd >>/dev/null
        LF_Positive_Output_Check
        echo $LV_RKHunterUpd_log>>$LOGFILE
        if [ "$UV_RKH_CHECK" = true ]; then
            log_message "$LV_RKHunterCheckInfo"
            log_message -n -e "$NORMAL $LV_RKHunterCheck \t \t "
            rkhunter --check --sk --rwo >>$LOGFILE
            LF_Positive_Output_Check
        fi
   else
        FEHLER=RKHunter-NotFound
        echo FAILURE RK-Hunter was not found >> $LOGFILE
        LF_Negative_Output_Check
   fi
}
