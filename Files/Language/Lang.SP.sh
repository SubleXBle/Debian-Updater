#!/bin/bash

### Funciones y Variables de Texto ###
# LF = Función de Lenguaje
# LV = Variable de Lenguaje
# LFA = Salida de LogFile

LV_Update_start="$NORMAL Ejecutando la actualización de repositorios \t \t \t "
LV_Update_done="Actualización ejecutada con éxito"
LV_Update_error="Error con apt-get update -q"
LV_RootCheck="Comprobando privilegios de root"
LV_Show_upgradeable="Mostrar paquetes actualizables:"
LV_Install="Actualizar paquetes instalados"
LV_Autoremove="Eliminar paquetes innecesarios"
LV_LogKiller="Eliminar archivo(s) de log"

LF_ISROOT_Pos() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}

LF_ISROOT_Neg() {
  echo -n -e "$NORMAL[$RED✗$NORMAL] ¡No tienes privilegios de ROOT! \t \t " 
  echo "Por favor, ejecuta el script con privilegios de ROOT (sudo)"; exit 1;
}

# Salida de Actualización / Upgrade / Autoremove - Positiva
LF_Positive_Output_Check() {
  log_message -n -e $"$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}
# Salida de Actualización / Upgrade / Autoremove - Negativa
LF_Negative_Output_Check() {
  log_message -n -e "$NORMAL[$RED✗$NORMAL] \t \t " | tee -a $LOGFILE
  log_message -e "$NORMAL Código de error: $RED $? $NORMAL" | tee -a $LOGFILE
}

LF_ErrorHandling_Y() {
  log_message -e $NORMAL "¡El script se ejecutó correctamente, no hubo $GREEN errores $NORMAL, el $GREEN sistema ha sido actualizado! $NORMAL"
}

LF_ErrorHandling_N() {
  log_message -e $NORMAL "¡Hubo $RED errores $NORMAL (Código de error: $RED $FEHLER $NORMAL)$NORMAL! Por favor, revisa el archivo de log en la siguiente ruta: $YELLOW $LOGFILE"
}

LF_ErrorHandling_RKH() {
  log_message -e $GREEN "RKHUNTER $NORMAL también fue $GREEN actualizado $NORMAL y se ejecutó una actualización de propiedades $GREEN! $NORMAL"
}

LF_Logline() {
  echo "=== NUEVO EJECUCIÓN DEL SCRIPT ===" >>$LOGFILE
}

LF_TimeOutput() {
  log_message -e $NORMAL "La actualización duró $YELLOW $((runtime / 60)) minutos $NORMAL y $YELLOW $((runtime % 60)) segundos $NORMAL."
}

LF_TimeOutput_Logfile() {
  echo "La actualización duró $((runtime / 60)) minutos y $((runtime % 60)) segundos." >>$LOGFILE
}

LF_LogRotationMaxAge() {
  log_message -e "Se eliminaron los archivos de log antiguos (más de $max_log_age días) \t $NORMAL[$GREEN✓$NORMAL]"
}

# Salidas de Logfile

LFA_Upgrade_Y="Upgrade ejecutado con éxito"
LFA_Upgrade_N="Error con apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove ejecutado con éxito"
LFA_Autoremove_N="Error con apt-get autoremove -y -q"
LFA_Notification_Option_notSet="No se ha habilitado ninguna opción de notificación externa"
LFA_LOGROTATION_Err_1="--No hay archivo de log para la rotación--"
LFA_NOOLDLOGS="No se encontraron archivos de log mayores a $LOGFILE_MAX_AGE días \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Comprobando RKHunter"
LV_RKHunterFound="RKHunter encontrado en el sistema"
LV_RKHunterUpd="Actualizando RKHunter y actualización de propiedades"
LV_RKHunterUpd_log="Actualización de RKHunter y propupd ejecutada"
LV_RKHunterCheckInfo="La comprobación de rootkits puede tardar un tiempo"
LV_RKHunterCheck="Comprobación de RKHunter para rootkits"

##### Nextcloud ####
LV_NC_APPS="Actualizar todas las aplicaciones de Nextcloud"

##### MediaWiki ####
LV_MW="Actualizar MediaWiki"
