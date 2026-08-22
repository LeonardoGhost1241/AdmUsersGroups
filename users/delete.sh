#!/bin/bash


# Verificar si existe el usuario

read -p "Ingresa usuario a eliminar: " userShow

if [[ ! -e "/home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh" ]]; then
    echo "[!] Archivo existUser.sh no encontrado"
    break
fi

. /home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh $userShow

userdel $userShow

