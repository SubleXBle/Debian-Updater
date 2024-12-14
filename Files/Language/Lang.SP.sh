#!/bin/bash

### TXT Funciones y Variables ###
# LF = Función de Lenguaje
# LV = Variable de Lenguaje
# LFA = Salida del LogFile

LV_Update_start="$NORMAL Ejecutando la actualización del repositorio \t \t \t "
LV_Update_done="Actualización completada con éxito"
LV_Update_error="Error durante apt-get update -q"
LV_RootCheck="Comprobando privilegios de root"
LV_Show_upgradeable="Mostrando paquetes:"
LV_Install="Actualizando paquetes instalados"
LV_Autoremove="Eliminando paquetes innecesarios"
LV_LogKiller="Borrando archivo(s) de log"
LV_NotificationNotSent="ERROR: No se pudo enviar la notificación!"
LV_NotificationSent="La notificación se envió con éxito"
LV_SendMessage="Enviando notificación"

LF_ISROOT_Pos() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}

LF_ISROOT_Neg() {
  echo -n -e "$NORMAL[$RED✗$NORMAL] ¡Sin privilegios ROOT! \t \t " 
  echo "Por favor, ejecute el script con privilegios ROOT (sudo)"; exit 1;
}

# Salida Update / Upgrade / Autoremove - Positiva
LF_Positive_Output_Check() {
  log_message -n -e $"$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}
# Salida Update / Upgrade / Autoremove - Negativa
LF_Negative_Output_Check() {
  log_message -n -e "$NORMAL[$RED✗$NORMAL] \t \t " | tee -a $LOGFILE
  log_message -e "$NORMAL Código de error: $RED $? $NORMAL" | tee -a $LOGFILE
}

LF_Fehlerbehandlung_Y() {
	log_message -e $NORMAL "El script ha finalizado, $GREEN no hubo errores $NORMAL, ¡el $GREEN sistema se actualizó! $NORMAL"
}

LF_Fehlerbehandlung_N() {
	log_message -e $NORMAL "Hubo $RED errores $NORMAL(Código de error: $RED $FEHLER $NORMAL)$NORMAL! Por favor, consulte el archivo de registro en la siguiente ruta:$YELLOW $LOGFILE"
}

LF_Fehlerbehandlung_RKH() {
	log_message -e $GREEN "RKHUNTER $NORMAL también se $GREEN actualizó $NORMAL y se realizó una $GREEN actualización de propiedades! $NORMAL"
}

LF_Logline() {
	echo "=== NUEVA EJECUCIÓN DEL SCRIPT ===">>$LOGFILE
}

LF_Zeitausgabe() {
	log_message -e $NORMAL "La actualización tomó $YELLOW $((runtime / 60)) minutos $NORMAL y $YELLOW $((runtime % 60)) segundos $NORMAL."
}

LF_Zeitausgabe_Logfile() {
	echo "La actualización tomó $((runtime / 60)) minutos y $((runtime % 60)) segundos.">>$LOGFILE
}

LF_LogRotationMaxAge() {
	log_message -e "Archivos de registro antiguos (más de $max_log_age días) eliminados \t $NORMAL[$GREEN✓$NORMAL]"
}

# Salidas del LogFile

LFA_Upgrade_Y="Actualización completada con éxito"
LFA_Upgrade_N="Error durante apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove completado con éxito"
LFA_Autoremove_N="Error durante apt-get autoremove -y -q"
LFA_Notification_Option_notSet="No se activó ninguna opción de notificación externa"
LFA_LOGROTATION_Err_1="--No hay archivo de registro para la rotación--"
LFA_NOOLDLOGS="No se encontraron archivos de registro más antiguos que $LOGFILE_MAX_AGE días \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Comprobando RKHunter"
LV_RKHunterFound="RKHunter encontrado en el sistema"
LV_RKHunterUpd="Actualizando RKHunter y actualización de propiedades"
LV_RKHunterUpd_log="Actualización y propupd de RK-Hunter completada"
LV_RKHunterCheckInfo="La comprobación de rootkits puede tardar algún tiempo"
LV_RKHunterCheck="RKHunter comprobando rootkits"

##### Nextcloud ####
LV_NC_APPS="Actualizando todas las aplicaciones de Nextcloud"

##### MediaWiki ####
LV_MW="Actualizando MediaWiki"
