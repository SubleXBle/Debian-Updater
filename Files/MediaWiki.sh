
MEDIAWIKI_UPDATE() {
  if [ -d "$UV_MW_PATH" ]; then
    log_message -n "$LV_MW: \t \t \t \t "
    php $UV_MW_PATH/maintenance/run.php update.php >> $LOGFILE
    LF_Positive_Output_Check
  else
    FEHLER=MediaWiki-NotFound
    LF_Negative_Output_Check
  fi
}
