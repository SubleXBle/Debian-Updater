#!/bin/bash

F_HELP() {
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Ayuda para el Script Debian-Updater" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e $BLUE "Script por SubleXBle (https://github.com/SubleXBle)" $NORMAL
    echo
    echo -e $TXTBOLD "Este script gestiona las actualizaciones del sistema y las notificaciones." $NORMAL
    echo
    echo -e $YELLOW $TXTBOLD "Opciones disponibles:" $NORMAL
    echo "  -s, --silent                Ejecuta el script en modo silencioso sin mostrar salida en la consola."
    echo "  -h, --help                  Muestra esta información de ayuda."
    echo "  -o, --onlyupdate            Actualiza solo los repositorios y muestra actualizaciones disponibles sin actualizar los paquetes."
    echo "  -n, --no-autoremove         Evita la eliminación automática de paquetes que ya no son necesarios después de la actualización."
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Variables de Usuario (en DEB_UPD_config.sh):" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e "$TXTBOLD Configuraciones en DEB_UPD_config.sh" $NORMAL
    echo -e "Archivos de registro"
    echo -e "Rotación de registros"
    echo -e "Notificaciones"
    echo -e "RK-Hunter"
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Funcionalidad:" $NORMAL
    echo -e $TXTBOLD "El script realiza los siguientes pasos:" $NORMAL
    echo "1. Verifica privilegios de root."
    echo "2. Actualiza los repositorios."
    echo "3. Muestra actualizaciones disponibles."
    echo "4. Actualiza los paquetes."
    echo "5. Elimina automáticamente paquetes que ya no son necesarios (si no está deshabilitado)."
    echo "6. Opcionalmente realiza comprobaciones de rootkits."
    echo "7. Gestión de archivos de registro: rotación y eliminación de archivos de registro antiguos."
    echo "8. Envía notificaciones en caso de errores o finalización exitosa (dependiendo de la configuración)."
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Uso:" $NORMAL
    echo "Para ejecutar el script, usa los siguientes comandos:"
    echo "./Debian-Updater.sh [opciones]"
    echo
    echo "p. ej.: ./Debian-Updater -n -s (Se ejecuta sin autoremove y en modo silencioso)"
    echo -e $BLUE "========================================" $NORMAL
}
