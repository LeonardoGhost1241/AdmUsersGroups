#!/bin/bash

PS3=">"

SCRIPT_USUARIOS="./admin_usuarios.sh"
SCRIPT_GRUPOS="./admin_grupos.sh"

opciones=("Gestión de Usuarios" "Gestión de Grupos" "Salir")

mostrar_encabezado() {
    clear
    echo "====================================================="
    echo "       ADMINISTRACIÓN DE USUARIOS Y GRUPOS           "
    echo "====================================================="
    echo ""
}

mostrar_encabezado

select opc in "${opciones[@]}"; do
    case $REPLY in
        1)
            echo -e "\n[+] Ejecutando módulo de Usuarios..."
            if [[ -x "$SCRIPT_USUARIOS" ]]; then
                "$SCRIPT_USUARIOS"
            else
                echo "Error: No se encontró o no tiene permisos de ejecución: $SCRIPT_USUARIOS"
            fi
            read -rp $'\nPresiona [Enter] para volver al menú...'
            mostrar_encabezado
            ;;
        2)
            echo -e "\n[+] Ejecutando módulo de Grupos..."
            if [[ -x "$SCRIPT_GRUPOS" ]]; then
                "$SCRIPT_GRUPOS"
            else
                echo "Error: No se encontró o no tiene permisos de ejecución: $SCRIPT_GRUPOS"
            fi
            read -rp $'\nPresiona [Enter] para volver al menú...'
            mostrar_encabezado
            ;;
        3)
            echo -e "\nSaliendo del sistema..."
            break
            ;;
        *)
            echo -e "\nOpción inválida. Intenta de nuevo."
            ;;
    esac
done


