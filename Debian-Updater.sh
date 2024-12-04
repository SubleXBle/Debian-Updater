# Setze die Variablen für Sanity-Check-Skripte (eins oder mehrere)
check1="Files/varcheckone.sh" # Sanity Check für Variablen
check2=""                     # Kann leer sein, wenn nicht benötigt

# Funktion zur Durchführung der Checks
check_scripts() {
  # Warte auf aktive Prozesse (dynamisch prüfen)
  while { [[ -n "$pid_varcheckone" ]] && kill -0 "$pid_varcheckone" 2>/dev/null; } || \
        { [[ -n "$pid_varchecktwo" ]] && kill -0 "$pid_varchecktwo" 2>/dev/null; }; do
    log_message $NORMAL
    log_message -n $NORMAL "Check Sanity [$YELLOW!$NORMAL]"
    sleep 1
    log_message -ne "\r"
  done

  # Überprüfe die Exit-Status (nur, wenn Prozess existiert)
  exit_status1=0
  exit_status2=0
  if [[ -n "$pid_varcheckone" ]]; then
    wait "$pid_varcheckone"
    exit_status1=$?
  fi
  if [[ -n "$pid_varchecktwo" ]]; then
    wait "$pid_varchecktwo"
    exit_status2=$?
  fi

  # Log-Ausgaben für Ergebnisse
  if [[ $exit_status1 -ne 0 || $exit_status2 -ne 0 ]]; then
    log_message $NORMAL "Sanity Checks failed $NORMAL[$RED✗$NORMAL]"
    exit 1
  else
    log_message -n $NORMAL "Checks done $NORMAL[$GREEN✓$NORMAL]"
    sleep 1
    log_message -ne "\r"
    log_message -n $NORMAL "Script starts $GREEN $NORMAL[$GREEN✓$NORMAL]"
    log_message $NORMAL
  fi
}

# Starte die Checks und speichere die PIDs, falls sie definiert sind
[[ -f "$check1" ]] && source "$check1" & pid_varcheckone=$!
[[ -f "$check2" ]] && source "$check2" & pid_varchecktwo=$!

# Rufe die Überprüfung auf
check_scripts
