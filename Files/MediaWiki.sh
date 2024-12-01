
MEDIAWIKI_UPDATE() {
  if exists $UV_MW_PATH; then
    log_message -n "$LV_MW: \t \t \t \t "
    ---- MEDIAWIKI UPDATE BEFEHL ----
    LF_Positive_Output_Check
  else
    FEHLER=MediaWiki-NotFound
    LF_Negative_Output_Check
  fi
}
