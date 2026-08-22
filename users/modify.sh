#!/bin/bash

#Verificar si existe el usuario

read -p "Ingresa cuenta de usuario: " userShow

#if [[ ! -e "/AdmUsersGroups/lib/existUser.sh" ]]; then
#    echo "[!] Archivo existUser.sh no encontrado"
#    exit 1 
#fi

#. /home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh $userShow

source ./variables_show.sh $userShow

echo "$id_user"






