#!/bin/bash

source /home/leonardo/Documents/AdmUsersGroups/lib/gfunctions.sh

read -p "Ingresa cuenta de usuario: " userShow

userExistCreate $userShow


opc=("Cambiar Nombre" "Cambiar id de usuario" "Cambiar id degrupo" "Cambiar/Eliminar/Agregar grupos" "Directorio principal" "Shell" "Comentario" "Estado de la cuenta" "Expiracion")


echo "Nombre: $name"
echo "id: $id_user"
echo "id de grupo: $id_group"
echo "Grupos: $allGroups"
echo "Directorio principal: $dirUser"
echo "Shell: $typeShell"
echo "Comantario: $comments"
echo "Estado de la cuenta: $accountStatus"
echo "Expiracion: $dateExpire"



nameFunc(){
    read -p "Nuevo nombre: " newName



}



PS3="> "
select var in "${opc[@]}"; do
    case $var in
        "Cambiar Nombre")
            echo "efvf"
            ;;
        "Cambiar id de usuario") 
            echo "dos"
            ;;
        "Cambiar id degrupo")
            echo ""
            ;;
        "Cambiar/Eliminar/Agregar grupos")
            ;;
        "Directorio principal")
            ;;
        "Shell")
            ;;
        "Comentario")
            ;;
        "Estado de la cuenta")
            ;;
        "Expiracion")
            ;;
        *)
            echo "Opcion no encontrada"
            ;;
    esac
done








