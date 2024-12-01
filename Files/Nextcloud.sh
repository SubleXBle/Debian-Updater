
if exists $UV_NC_OCC_PATH; then
  log_message -n "$LV_NC_APPS: \t \t \t \t "
  sudo -u www-data php $UV_NC_OCC_PATH/occ app:update
  LF_Positive_Output_Check
fi
