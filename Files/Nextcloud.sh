
NC_APP_UPDATE() {
  if [ -d "$UV_NC_OCC_PATH" ]; then
    log_message -n "$LV_NC_APPS: \t \t \t \t "
    sudo -u www-data php $UV_NC_OCC_PATH/occ app:update --all >> $LOGFILE
    LF_Positive_Output_Check
  else
    FEHLER=Nextcloud-NotFound
    LF_Negative_Output_Check
  fi
}
