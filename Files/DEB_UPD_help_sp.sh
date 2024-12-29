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
    echo "  -h, --help                  Muestra esta ayuda."
    echo "  -o, --onlyupdate            Actualiza solo los repositorios y muestra las actualizaciones disponibles sin actualizar los paquetes."
    echo "  -n, --no-autoremove         Evita la eliminación automática de paquetes innecesarios después de la actualización."
    echo "  -d, --dist-upgrade          Realiza una actualización de distribución una sola vez."
    echo "  -tn, --test-notifications   para probar la configuración de notificaciones"
    echo
    echo -e $BLUE "========================================"
    echo -e $YELLOW $TXTBOLD "Variables del usuario (en DEB_UPD_config.sh):" $NORMAL
    echo -e $BLUE "========================================" $NORMAL
    echo -e "$TXTBOLD Configuraciones en DEB_UPD_config.sh" $NORMAL
    echo -e "Archivos de registro"
    echo -e "Rotación de registros"
    echo -e "Notificaciones"
    echo -e "RK-Hunter"
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Cómo funciona:" $NORMAL
    echo -e $TXTBOLD "El script realiza los siguientes pasos:" $NORMAL
    echo "1. Verifica los privilegios de root."
    echo "2. Actualiza los repositorios."
    echo "3. Muestra las actualizaciones disponibles."
    echo "4. Actualiza los paquetes."
    echo "5. Elimina automáticamente los paquetes innecesarios (si no está deshabilitado)."
    echo "6. Opcionalmente, realiza una verificación de rootkits."
    echo "7. Gestión de archivos de registro: rotación y eliminación de registros antiguos."
    echo "8. Envia notificaciones en caso de errores o finalización exitosa (dependiendo de la configuración)."
    echo
    echo -e $BLUE "========================================" $NORMAL
    echo -e $YELLOW $TXTBOLD "Uso:" $NORMAL
    echo "Para ejecutar el script, usa el siguiente comando:"
    echo "./Debian-Updater.sh [Opciones]"
    echo
    echo "Ejemplo: ./Debian-Updater -n -s (No realiza autoremove y se ejecuta en modo silencioso)"
    echo -e $BLUE "========================================" $NORMAL
}
