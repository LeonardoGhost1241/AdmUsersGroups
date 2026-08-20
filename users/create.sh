#!/bin/bash

final=()

read -p "Nombre del nuevo usuario: " newUser

# Verificar si el usuario existe


uiUser(){
    read -p "Definir User id? y/n: " uiOpc

    if [[ "$uiOpc" == "y" ]]; then
        echo "[!] UID mayor a 1000"
        #verificar si es mayor que 1000 y diferente a 0 
        final+=("-u" "$uid") ##agregar numero
    fi
}

skelDir(){
    read -p "Agregar contenido del directorio y/n : " skelOpc

    skelDir="/etc/skel"

    if [[ "$skelOpc" =~ ^[Yy]$ ]]; then
        read -p "Ruta skel por defecto $skelDir, cambiar la ruta y/n: " skelOpc2
        
        case "$skelOpc2" in
            "Y"|"y")
                read -p "Nueva ruta del directorio skel: " newSkelDir
                skelDir="$newSkelDir"
                ;;
             *)
                ;;
        esac

        final+=("-k" "$skelDir")
    fi

}


dirUser(){
    read -p "Crear un directorio? y/n: " dirOpc

    if [[ "$dirOpc" == "y" || "$dirOpc" == "Y" || -z "$dirOpc" ]]; then
        final+=("-m")
        
        read -p "Directorio dentro de /home? y/n: " dirOpc2

        case "$dirOpc2" in
            "N"|"n")
                read -p "Especifica la nueva ruta del directorio home del usuario: " newDir
                finalPath="$newDir/$newUser"
                final+=("-d")
                final+=("$finalPath")
                skelDir
                ;;
             "Y"|"y")
                skelDir
                ;;
             *)   
                ;;
        esac  
    elif [[ "$dirOpc" == "n" || "$dirOpc" == "N" ]]; then
        final+=("-M")
    elif [[ -z "$dirOpc" ]]; then
        echo "[!] Creando usuario sin directorio..."
        final+=("-M")
    else
        echo "[!] Opcion no encontrada..."
        final+=("-m")
    fi
}


shellUser(){
    read -p "Tipo de shell bash/zsh/sh/fish/ksh" shellOpc
    final+=("-s")

    if [[ "$shellOpc" == "bash" ]]; then
        final+=("/bin/bash")
    elif [[ "$shellOpc" == "zsh" ]]; then
        final+=("/bin/zsh")
    elif [[ "$shellOpc" == "fish" ]]; then
        final+=("/bin/fish")
    elif [[ "$shellOpc" == "ksh" ]]; then
        final+=("/bin/ksh")
    elif [[ -z "$shellOpc" ]]; then
        final+=("/bin/bash")
    fi
}



groupsUser(){
    gList=()
    addGroup="true"

    read -p "Agregar a grupos secundarios?? y/n: " gOpc

    if [[ "$gOpc" =~ ^[Yy]$ ]]; then
        while [ "$addGroup" == "true" ]
        do
            read -p "Nombre del grupo: " group
            gList+=("$group")

            read -p "Agregar otro grupo? y/n: " oneMore
            if [[ "$oneMore" =~ ^[Nn]$ ]];then
                break;
            fi
        done

        local groups=$(IFS=,; echo "${gList[*]}")
        final+=("-G" "$groups")
    fi
}

expireUser(){

    select var in "Establecer el numero de dias donde expire la constraseña" "Establecer fecha de expiracion de la cuente" "No establecer nada "; do
        case $var in 
            "Establecer fecha de ex    piracion de la cuente")
                read -p "Fecha de expiracion a la cuenta? (Formato YYYY-MM-DD): " expireDate
                read -p  "Formato YYYY-MM-DD: " expireDate
                final+=("-e")
                final+=("$expireDate")
                ;;
            "Establecer el numero de dias donde expire la constraseña")
                read -p "Numero de dias: " expirePasswd
                final+=("-f")
                final+=("$expirePasswd")
                ;;
            *)
                break
                ;;
         esac
    done
}

commentUser(){
    read -p "Agregar un comentario? y/n " commOpc

    if [[ "$commOpc" =~ ^[Yy]$ ]];then
        read -p "Comentario: " commentary
        final+=("-c")
        final+=("\"$commentary\"")
    fi
}


#verificar si el usuario existe
uiUser
dirUser
shellUser
groupsUser
expireUser
commentUser


echo  "${final[@]}" $newUser
