#!/bin/bash

final=()

# [Pendiente: Función de verificación de usuario existente]

uiUser(){
    read -p "¿Definir User ID (UID)? [y/N]: " uiOpc
    if [[ "$uiOpc" =~ ^[Yy]$ ]]; then
        read -p "Introduce el UID: " uid
        # [Pendiente: Verificar si es mayor que 1000 y diferente a 0]
        final+=("-u" "$uid")
    fi
}

skelDir(){
    read -p "¿Copiar contenido de plantilla (skel)? [y/N]: " skelOpc
    local skelDir="/etc/skel"

    if [[ "$skelOpc" =~ ^[Yy]$ ]]; then
        read -p "Ruta skel por defecto es ($skelDir). ¿Cambiar ruta? [y/N]: " skelOpc2
        if [[ "$skelOpc2" =~ ^[Yy]$ ]]; then
            read -p "Nueva ruta del directorio skel: " newSkelDir
            skelDir="$newSkelDir"
        fi
        final+=("-k" "$skelDir")
    fi
}

dirUser(){
    read -p "¿Crear directorio personal (home)? [Y/n]: " dirOpc

    if [[ "$dirOpc" =~ ^[Yy]$ || -z "$dirOpc" ]]; then
        final+=("-m")
        read -p "¿Directorio dentro de /home? [Y/n]: " dirOpc2

        if [[ "$dirOpc2" =~ ^[Nn]$ ]]; then
            read -p "Especifica la ruta base (ej. /data): " newDir
            final+=("-d" "$newDir/$newUser")
        fi
        skelDir
    else
        final+=("-M")
    fi
}

shellUser(){
    read -p "Shell por defecto [/bin/bash]: " shellOpc
    if [[ -z "$shellOpc" ]]; then
        shellOpc="bash"
    fi

    case "$shellOpc" in
        bash) final+=("-s" "/bin/bash") ;;
        zsh)  final+=("-s" "/bin/zsh") ;;
        fish) final+=("-s" "/usr/bin/fish") ;;
        ksh)  final+=("-s" "/bin/ksh") ;;
        sh)   final+=("-s" "/bin/sh") ;;
        *)    final+=("-s" "$shellOpc") ;;
    esac
}

groupsUser(){
    local gList=()
    read -p "¿Agregar a grupos secundarios? [y/N]: " gOpc

    if [[ "$gOpc" =~ ^[Yy]$ ]]; then
        while true; do
            read -p "Nombre del grupo: " group
            # [Pendiente: Verificar si el grupo existe en el sistema]
            [[ -n "$group" ]] && gList+=("$group")

            read -p "¿Agregar otro grupo? [y/N]: " oneMore
            [[ "$oneMore" =~ ^[Nn]$ || -z "$oneMore" ]] && break
        done

        if [[ ${#gList[@]} -gt 0 ]]; then
            local groups
            groups=$(IFS=,; echo "${gList[*]}")
            final+=("-G" "$groups")
        fi
    fi
}

expireUser(){
    read -p "Fecha de expiracion de la cuenta (YYYY-MM-DD)" expireDate

    final+=("-e" "$expireDate")

#    echo "--- Opciones de expiración ---"
#    PS3="Selecciona una opción: "
#    select var in "Establecer fecha de expiración de la cuenta" "Días de inactividad tras caducar contraseña" "Omitir"; do
#        case $REPLY in 
#            1)
#                read -p "Fecha de expiración (YYYY-MM-DD): " expireDate
#                final+=("-e" "$expireDate")
#                break
#                ;;
#            2)
#                read -p "Número de días de inactividad (-f): " expirePasswd
#                final+=("-f" "$expirePasswd")
#                break
#                ;;
#            *)
#                break
#                ;;
#         esac
#    done
}

commentUser(){
    read -p "¿Agregar un comentario/nombre completo? [y/N]: " commOpc
    if [[ "$commOpc" =~ ^[Yy]$ ]]; then
        read -p "Comentario: " commentary
        final+=("-c" "\"$commentary\"")
    fi
}

# Ejecución de módulos

echo
echo "---------------------------------------------"
read -p "Nombre del nuevo usuario: " newUser
echo
uiUser
echo
dirUser
echo
shellUser
echo
groupsUser
echo
expireUser
echo
commentUser

# Ejecución final del comando
echo -e "\n[+] Comando a ejecutar:"
echo "useradd ${final[*]} $newUser"

echo 
read -p "¿Deseas crear el usuario ahora mismo? [y/N]: " runCmd
if [[ "$runCmd" =~ ^[Yy]$ ]]; then
    useradd "${final[@]}" "$newUser"
    if [[ $? -eq 0 ]]; then
        echo "Usuario $newUser creado exitosamente"
    else
        echo "[!] Error al crear el usuario"
    fi
fi
