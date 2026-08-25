#!/bin/bash

# import variables_show file, to use show function 
source  ./variables_show.sh

read -p "Ingresa nombre de usuario: " userShow


# Verificar si existe el usuario
#if [[ ! -e "/home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh" ]]; then
#    echo "[!] Archivo existUser.sh no encontrado"
#    break
#fi

# existFunction(){
#. /home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh $userShow
#}


BannerU(){
    echo
    echo "      ------------------------"
    echo "      |   User information   |"
    echo "      ------------------------"
    echo
}

#existFunction
BannerU
# printInfo
show $userShow


