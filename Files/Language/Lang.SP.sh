#!/bin/bash

### Funciones y Variables de TXT ###
# LF = Función de Lenguaje
# LV = Variable de Lenguaje
# LFA = Salida de Archivo de Registro

LV_Update_start="$NORMAL Ejecutando actualización para los repositorios \t \t "
LV_Update_done="Actualización completada con éxito"
LV_Update_error="Error con apt-get update -q"
LV_RootCheck="Verificando privilegios de root \t "
LV_Show_upgradeable="Mostrar paquetes:"
LV_Install="Actualizando paquetes instalados \t \t "
LV_Autoremove="Eliminando paquetes que ya no son necesarios \t "
LV_LogKiller="Eliminando archivo(s) de registro" 

LF_ISROOT_Pos() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}

LF_ISROOT_Neg() {
  echo -n -e "$NORMAL[$RED✗$NORMAL] ¡Sin privilegios de ROOT! \t \t "
  echo "Por favor, ejecute el script con privilegios de ROOT (sudo)"; exit 1;
}

# Salida de Actualización / Mejora / Autoremove - Positiva
LF_Positive_Output_Check() {
  log_message -n -e "$NORMAL[$GREEN✓$NORMAL] \t \t "
  log_message ""
}
# Salida de Actualización / Mejora / Autoremove - Negativa
LF_Negative_Output_Check() {
  log_message -n -e "$NORMAL[$RED✗$NORMAL] \t \t " | tee -a $LOGFILE
  log_message -e "$NORMAL Código de error: $RED $? $NORMAL" | tee -a $LOGFILE
}

LF_Fehlerbehandlung_Y() {
	log_message -e $NORMAL "El script se completó sin errores; $GREEN no se produjeron errores $NORMAL, y el $GREEN sistema ha sido actualizado! $NORMAL"
}

LF_Fehlerbehandlung_N() {
	log_message -e $NORMAL "$RED Errores $NORMAL(código de error: $RED $FEHLER $NORMAL)$NORMAL ocurrieron! Por favor, verifique el archivo de registro en la siguiente ruta: $YELLOW $LOGFILE"
}

LF_Fehlerbehandlung_RKH() {
	log_message -e $GREEN "RKHUNTER $NORMAL también fue $GREEN actualizado $NORMAL, y se realizó una $GREEN actualización de propiedades! $NORMAL"
}

LF_Logline() {
	echo "=== NUEVO EJECUCIÓN DEL SCRIPT ===">>$LOGFILE
}

LF_Zeitausgabe() {
	log_message -e $NORMAL "La actualización tomó $YELLOW $((runtime / 60)) minutos $NORMAL y $YELLOW $((runtime % 60)) segundos $NORMAL."
}

LF_Zeitausgabe_Logfile() {
	echo "La actualización tomó $((runtime / 60)) minutos y $((runtime % 60)) segundos.">>$LOGFILE
}

LF_LogRotationMaxAge() {
	log_message -e "Archivos de registro antiguos eliminados (mayores de $max_log_age días) \t $NORMAL[$GREEN✓$NORMAL]"
}

# Salidas de Archivo de Registro

LFA_Upgrade_Y="Actualización completada con éxito"
LFA_Upgrade_N="Error con apt-get upgrade -y -q"
LFA_Autoremove_Y="Autoremove completado con éxito"
LFA_Autoremove_N="Error con apt-get autoremove -y -q"
LFA_Notification_Option_notSet="No se ha habilitado ninguna opción de notificación externa"
LFA_LOGROTATION_Err_1="--Sin archivo de registro para rotación--"
LFA_NOOLDLOGS="No se encontraron archivos de registro más antiguos que $LOGFILE_MAX_AGE días \t $NORMAL[$YELLOW!$NORMAL]"

#### RK Hunter ####

LV_CheckIfRKHunter="Verificando RKHunter"
LV_RKHunterFound="RKHunter encontrado en el sistema"
LV_RKHunterUpd="Actualizando RKHunter y realizando actualización de propiedades"
LV_RKHunterUpd_log="Actualización de RK-Hunter y propupd completadas"
LV_RKHunterCheckInfo="La verificación de rootkits puede tardar un tiempo"
LV_RKHunterCheck="RKHunter verificando rootkits"
