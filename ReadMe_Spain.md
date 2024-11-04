Debian-Updater
Versión: 0.7
Autor: SubleXBle
Repositorio: GitHub: SubleXBle
Descripción
El script Debian-Updater automatiza la actualización de un sistema basado en Debian (Debian, Ubuntu, Kali, Mint, RaspberryOS, etc.). Verifica los privilegios de root, actualiza las fuentes de paquetes y los paquetes instalados, elimina paquetes innecesarios a petición y, opcionalmente, revisa el sistema en busca de rootkits. Además, ofrece la opción de enviar notificaciones o el archivo de registro mediante Pushover, Telegram o Gotify, o de conservar los archivos de registro a largo plazo mediante la rotación de logs.

El script es adecuado para ejecutarse como una tarea cron gracias a su modo --silent, manejo de errores y robustez. La variedad de opciones de registro permite casi cualquier configuración de logs (rotación de logs, conservar solo en caso de errores, conservar solo por X días, sin registro, enviar logs, etc.).

Funciones
Actualización del sistema: Actualiza las fuentes de paquetes (apt-get update), instala actualizaciones disponibles (apt-get upgrade) y elimina paquetes innecesarios (apt-get autoremove).
Registro: Todas las actividades se escriben en un archivo de registro que puede ser opcionalmente guardado, enviado o eliminado. Algunas funciones de archivo de registro se han implementado para cumplir con cada preferencia en el manejo de logs. Estas pueden ser controladas a través del archivo de configuración (DEB_UPD_config.sh).
Rotación de logs: Si el archivo de registro se retiene, hay una rotación diaria de logs o eliminación automática después de X días.
Notificaciones opcionales solo en caso de errores.
Las notificaciones y el archivo de registro se pueden enviar a través de una variedad de servicios:
Correo electrónico (SMTP) a través de Curl
Pushover (https://pushover.net/) (API)-Llamada a través de CURL
Telegram (https://web.telegram.org) (API)-Llamada a través de CURL
Gotify (https://gotify.net/) (API)-Llamada a través de CURL
Discord (https://discord.com/) (Webhook) a través de Curl
MS-Teams (Webhook) a través de Curl
Seguimiento de tiempo de ejecución: El script mide y registra el tiempo total de ejecución.
Modo silencioso: Opción para suprimir la salida de la consola, permitiendo que el script se ejecute en tareas cron, por ejemplo.
Actualización y/o verificación opcional de RKHunter: Realiza una verificación de rootkits y actualiza RKHunter si está instalado y activado.
Uso
./Debian-Updater.sh [-OPCIÓN1 -OPCIÓN2 etc.]

Opciones
-h, --help : Muestra una página de ayuda con las opciones disponibles.
-s, --silent : Suprime la salida de la consola; el archivo de registro aún se crea.
-o, --onlyupdate : Solo actualiza las fuentes de paquetes (apt-get update) sin actualizar los paquetes.
-n, --no-autoremove : No se realizará autoremove.
-l, --license : Muestra la licencia.
Salida clara
La salida del script (cuando no está en modo --silent como tarea cron) está diseñada para ser clara. El archivo de registro es fácil de leer; para múltiples ejecuciones que terminan en un mismo registro, se inserta una línea separadora así como la fecha y la hora. Además, hay una rotación diaria de logs. Actualmente se está trabajando en una salida en inglés; ya se puede configurar a través del archivo de configuración (DEB_UPD_config.sh) y la variable $UV_LNG.

Configuración
Archivo de Configuración (DEB_UPD_config.sh)
Todas las opciones se pueden configurar a través de un archivo de configuración en la carpeta principal. El archivo de configuración está disponible tanto en alemán como en inglés para facilitar a los usuarios realizar las configuraciones correctas.

Para usar el archivo de configuración en inglés, el archivo DEB_UPD_config.sh.ENGLISH debe renombrarse a DEB_UPD_config.sh (mv DEB_UPD_config.sh.ENGLISH DEB_UPD_config.sh).

Archivos de Configuración para Notificaciones
Cada método de envío de notificaciones tiene su propio archivo de configuración en la carpeta NotificationConfiguration para establecer la conexión con el servicio respectivo (usuario, contraseña, etc.).

Requisitos
Un sistema basado en Debian. (Debian / Raspberry Pi OS / Ubuntu / Linux Mint / Kali Linux: Wikipedia lista de derivados de Debian)
El script principal (Debian-Updater.sh) debe hacerse ejecutable (chmod +x Debian-Updater.sh).
Privilegios de root.
Opcional: RKHunter (https://rkhunter.sourceforge.net/)
Si RKHunter está instalado en el sistema, puede actualizarse simultáneamente.
Si RKHunter está instalado, también se puede ejecutar una verificación (--check) inmediatamente después de la actualización.
Para notificaciones, debe estar instalado "curl" (https://curl.se/).
Descripción de la Versión
Todas las posibles mejoras, ajustes y sugerencias...
Salidas mejoradas...
Trabajo en las traducciones...
Licencia
Licencia Pública General de GNU v3.0
Este script es de código abierto y puede ser libremente utilizado y modificado.
Desarrollo Futuro
Actualizaciones y mejoras continuas.

Dado que uso el script para mis propios sistemas, ciertamente habrá expansiones (como RKHunter).
Posiblemente convertirlo en un actualizador universal que admita muchas/todas las distribuciones de Linux.
/fun
Chat-GPT dice:
Este script de Bash implementa un sistema completo para gestionar actualizaciones del sistema, notificaciones y archivos de registro de sistemas Debian.
Esta estructura modular y flexible, con interruptores configurables y lógica detallada para ejecutar actualizaciones y notificaciones, hace que el script sea particularmente adecuado para entornos de producción. Al automatizar las actualizaciones del sistema y recibir notificaciones inmediatas, los administradores pueden asegurarse de que sus sistemas estén siempre actualizados y seguros.
