if exists $UV_NC_OCC_PATH; then
  sudo -u www-data php $UV_NC_OCC_PATH/occ app:update
fi


UV_NC_APP_Update=false                          # Wenn auf true gesetzt, wird das Script ebenfalls App-Updates für Nextcloud ausführen
UV_NC_OCC_PATH="/path/to/your/Nextcloud"
