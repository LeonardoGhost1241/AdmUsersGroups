#!/bin/bash

CREATE_FILE="./create.sh"
SHOW_FILE="show.sh"
DELETE_FILE="delete.sh"
MODIFY_FILE="modify.sh"

if [[ ! -e "$CREATE_FILE" || ! -e "$SHOW_FILE" || ! -e "$DELETE_FILE" || ! -e  "$MODIFY_FILE" ]]; then
    echo "Uno o mas archivos no encontrados"
    break  
fi

PS3="Seleccione una opcion> "

menu=()
menu+=("Crear usuario")
menu+=("Modificar usuario")
menu+=("Mostrar informacion de un usuario")
menu+=("Eliminar usuario")
menu+=("Regresar")


showMenu(){
    echo "########################"
    echo "# ADMINISTRAR USUARIOS #"
    echo "########################"
    echo ""
}

clear
showMenu
select var in "${menu[@]}"; do
    case "$REPLY" in
        1)
            bash "$CREATE_FILE"
            echo
            read -rp 'Presiona [Enter] para continuar...'
            ;;
        2)
            bash "$MODIFY_FILE"
            echo 
            read -rp "Presiona [Enter] para continuar..."
            ;;
        3)
            bash "$SHOW_FILE"
            read -rp "Presiona [Enter] para continuar..."
            ;;
        4)
            bash "$DELETE_FILE"
            read -rp "\nPresiona [Enter] para continuar..."
            ;;
        5)
            break
            ;;
        *)
            echo "Opcion no encontrada"
            ;;
    esac
    clear 
    showMenu
done
