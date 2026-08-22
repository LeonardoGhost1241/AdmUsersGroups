#!/bin/bash

read -p "Ingresa nombre de usuario: " userShow


# Verificar si existe el usuario
if [[ ! -e "/home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh" ]]; then
    echo "[!] Archivo existUser.sh no encontrado"
    break
fi

existFunction(){
. /home/leonardo/Documents/AdmUsersGroups/lib/existUser.sh $userShow
}


printBanner(){
    echo
    echo "      ------------------------"
    echo "      |   User information   |"
    echo "      ------------------------"
    echo
}


source ./variables_show.sh $userShow

#name="$userShow"
#id_user=$(getent passwd | grep "^$userShow:*" | cut -d ":" -f 3)
#id_group=$(getent passwd | grep "^$userShow:*" | cut -d ":" -f 4)
#allGroups=$(groups $userShow | cut -d ":" -f 2 | xargs)
#dirUser=$(getent passwd | grep "^$userShow:*" | cut -d ":" -f 6) 
#typeShell=$(getent passwd | grep "^$userShow:*" | cut -d ":" -f 7)
#comments=$(getent passwd | grep "^$userShow:*" | cut -d ":" -f 5) 
#accountStatus=$(statusA)
#dateExpire=$(chage -l $userShow | grep "Account expires" | cut -d ":" -f 2 | xargs)


printInfo(){
    echo "Nombre: $name          ID:$id_user,IDG:$id_group"
    echo "Grupos: $allGroups"
    echo "Directorio principal: $dirUser"
    echo "Shell: $typeShell"
    echo "Estado de la cuenta: $accountStatus"
    echo "Fecha de expiracion de la cuenta: $dateExpire"
    echo "Comentarios: $comments"
}


existFunction
printBanner
printInfo


