#!/bin/bash

# Creacion de usuarios y grupos y demas

#Para un usuario UID
#Para un grupo GID
#cuando se crea un grupo en el sistema, se asigna un GID de 1000 o superior. Aquellos grupos que poseen un GID menor a 100 se consideran reservados y son de uso de grupos espciales o del propio sistema operativo 


#Archivos relacionados con la administracion de usuarios y grupos 
#/etc/passwd	Contiene informacion acerca de los usuarios
#	Donde la sintaxis es la siguiente:
#	Nombre de usuario : x : UID : GID : descripción : dir.inicio : intérprete	--> Fabian : x : 102 : 100 : Fabian Guber : /home/fabian : /bin/bash
#				Nombre de usuario: nombre del usuario
#				X:	Contraseña cifrada, hace uso del archivo /etc/shadow
#				UID:	Numero unico dado a cada usuario del sistema
#				GID:	Es el numero unico que identifica al grupo 
#				Descripcion:	ALguna descripcion del usuario
#				dir.inicio:	Este es el directorio en el que se coloca inicialmente al usuario en el momento de conexion 
#				Interprete:	El tipo de terminal cuando se conecta 
#
#/etc/shadow	Contiene contraseñas cifradas 
#	Donde la sintaxis es la siguiente:
#	Nombre de usuario : clave : UC : PC : DC : CC : AD : CD : R
#				Nombre de usuario:nombre del usuario
#				clave:	Password cifrada
#				UC:	Cantidad de dias desde la fecha 01/01/1970
#				PC:	Minimo de dias que deben pasar hasta que se pueda cambiar la contraseña
#				DC:	Maximo de dias que deben pasar para la caducidad de la contraseña y deba ser cambiada
#				CC:	Cantidad de dias de antelacion para que el sistema notifique la caducidad de la contraseña
#				AD:	Cantidad de dias con la contrasela caducada antes que la cuenta se deshabilite
#				CD:	Cantidad de dias desde la fecha 01/01/1970 y el dia en que la cuenta se deshabilito
#				R:	Es un campo reservado 
#
#/etc/group	Contienen informacion acerca de los grupos
#	Donde la sintaxis es la siguiente:
#	nombre de grupo : clave : GID : otros miembros
#				nombre del grupo:	Nombre del grupo 
#				clave:	La contraseña cifrada para el grupo o una x indicando la existencia del archivo /etc/gshadow
#				GID:	Numero de indentificacion del grupo
#				Otros miembros:	Lista de los usuarios que pertenecen al grupo, separados por (,). Tambien se pueden añadir usuarios que pertenecen a otros grupos, de este modo asumen los privilegios de ese grupo
#
#/etc/gshadow	Contiene contraseñas cifradas para grupos 
#	Donde la sintaxis es la siguiente:
#	nombre : contraseña:uid:gid:descripción opcional carpeta:Shell
#				Nombre:	Nombre de usuario
#				Contraseña: contraseña del grupo
#					Si hay una x, la contrasela esta cifrada en el /etc/shadow (Si tenemos la x, los usuarios que no pertenezcan al grupo pueden unirse a este escribiendo la contraseña para ese grupo usando el comando newgrp)
#					Si es un signo !, significa que ningun usuario tiene acceso al grupo usuando el comando newgrp
#					Si el valor es nulo, solamente los miembros del grupo pueden conectarse al grupo 
#				UID:	Numero de indetificacion del grupo
#				GID:	Numero de indentificacdor de grupo
#				Carpeta:	Directorio de inicio de sesion del usuario
#				Shell:	Existen usuarios que no tienen shell

#
#	comandos de grupo 
#		groupadd - Crea una nueva cuenta de grupo
#		groupmod - Permite modificar atributos de un grupo ya existente		
#		groupdel - Elimina una cuenta de grupo
#		gpasswd	 - Permite cambiar la contraseña del grupo
#		grpconv y grpuncov - Estos comandos convierten al formato gshadow o eliminan el formato gshadow 
#		newgrp - Permite hacer un usuario cambie su grupo principal de forma temporal 
#
#
#	Comandos de usuario
#		useradd comando nativo de linux 
#		useradd 
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#




echo	"###############################################"
echo 	"###   ADMINISTRACION DE USUARIOS Y GRUPOS   ###"
echo	"###############################################" 

#CRUD (CREATE READ UPDATE DELETE)

PS3="Select Option> "

group(){
	groupArr=()

	select var in "Crear grupo" "Listar grupos" "Actualizar grupo" "Eliminar grupo" "Menu principal"; do
		case $var in 
			"Crear grupo")
				gCreate
				;;				
			"Listar grupos") 
				gShow 
				;;
			"Actualizar grupo")
				groupModify	
				;;
			"Eliminar grupo")
				groupDelete
				;;
			"Menu principal")
				break
				;;
			*)
				echo "Opcion no encontrada... "
				exit 0
				;;
		esac 
	done

}

user(){
	userArr=()
	uASecGroups=("-G" )

	select var in "Crear usuario" "Listar usuarios" "Actualizar usuario" "Eliminar usuario" "Menu principal"; do
		case $var in 
			"Crear usuario")
				uCreate
				echo useradd "${uASecGroups[*]}" "${userArr[*]}" "$user"
				;;				
			"Listar usuarios") 
				uShow 
				;;
			"Actualizar usuario")
				uModify	
				;;
			"Eliminar usuario")
				uDelete
				;;
			"Menu principal")
				break;;
			*)
				echo "Opcion no encontrada... "
				exit 0
				;;
		esac 
	done
}


uCreate(){
	read -p "Nombre del nuevo usuario: " user
	if getent passwd | cut -d ":" -f 1 | grep "^$user$"  >/dev/null 2>&1 ; then
		echo "El nombre de usuario ya esta en uso..."
		exit 1
	fi

	read -p "Numero identificador del usuario [mayor a 1001]: " uid
	if  getent passwd | cut -d ":" -f 3 | grep "^$uid$"; then
		echo "El numer identificador ya esta en uso"
		exit 1
	elif [[ $uid -lt 1001 ]]; then
		echo "Fuera del rango permitido"
		exit 1
	else
		userArr+=("-u $uid")
	fi

	read -p "Grupo primario [por defecto:sea crea un grupo llamado $user]: " gprimary
	if [[ -z "$gprimary" ]]; then
		userArr+=("-g $user")
	else
		userArr+=("-g $gprimary")
	fi


	read -p "Agregar grupos secundarios: y/n " opcsg 
	if [[ "$opcsg" == "y" ]]; then
		while true; do 
			read -p "Grupo secundario: " secundaryG
			uASecGroups+=("$secundaryG")

			read -p "Agregar mas grupos?: y/n " opcsg2
			if [[ "$opcsg2" == "n" || -z "$opcsg2" ]]; then
				break;
			fi
		done
	fi

	read -p "Asignar directorio [default:/home/$user]: y/n " dirUser
	if [[ "$dirUser" == "y" ]]; then
		read -p "Ruta del directorio: " $dirPath
		userArr+=("-d $dirPath")
	else
		userArr+=("-m -d /home/$user")
	fi

	read -p "Descripcion o comentario: " comment
	userArr+=("-c \"$comment\" ")

	read -p "Tipo de shell [bash,ssh,etc]: " shell
	userArr+=("-s $(which $shell)")

	read -p "Definir caducidad de la cuenta y/n " opct
	if [[ "$opct" == "y" ]]; then
		read -p "Siguiendo el formato AAAA-MM-DD [ejem:2025-12-31]: " cad
		userArr+=("-e $cad")
	fi

	echo "Defina una contraseña para el usuario: "
	read -s password
	userArr+=("-p $password")
}




uShow(){
	select var in "Ver todos los usuarios" "Ver info de un usuario" "Menu usuarios"; do
		case $var in 
			"Ver todos los usuarios")
				getent group
				;;

			"Ver info de un usuario")
				read -p "Nombre del usuario: " userInfo
				if getent passwd | cut -d ":" -f 1 | grep "^$userInfo$"; then
					finger "$userInfo"
					if [[ $? -ne 0 ]];then
						echo "necesita el comando finger para ver la info de un usuario"
						exit 1
					fi
				fi
				;;
			"Menu usuarios")
				break;;
			*)
				break
				;;
		esac 

	done

}

uDelete(){
	read -p "Nombre del usuario a borrar: " nameDel
	uExist $nameDel
	echo userdel $nameDel

#	if getent passwd | cut -d ":" -f 1 | grep "^nameDel$"; then
#		echo userdel $nameDel
#		echo "[!] Recuerde borrar/mover el directorio del usuario eliminado"
#	else
#		echo "Nombre no encontrado"
#	fi
}

uModify(){
	opcUA=("Cambiar ID de usuario" 
		"Cambiar descripcion" 
		"Cambiar directorio principal de un usuario" 
		"Cambiar shell de un usuario" 
		"Bloquear cuenta" 
		"Desbloquear cuenta" 
		"Cambiar grupo primario" 
		"Cambiar grupo secundario"
		"Menu usuario")

	select var in "${opcUA[@]}"; do
		case $var in
		"Cambiar ID de usuario")
			read -p "usuario: " user
			uExist user

#			if ! getent passwd | cut -d ":" -f 1 | grep "^$user$" >/dev/null 2>&1; then
#				echo "NO existe el usuario"
#				exit
#			fi

			echo "ID actual: $(getent passwd | grep -i "^$user:" | cut -d ":" -f 3)"
			read -p "Ingrese el nuevo Id de usuario: " iduser
			if getent passwd | cut -d ":" -f 3 | grep "$iduser" >/dev/null 2>&1 ; then #puedes usar grep -q que busca silenciosamente y solo devuelve el codigo de salida en lugar de usar /dev/null 2>&1
				echo "ID en uso"
				getent passwd | grep -i $iduser
			else
				echo usermod -u "iduser" "$user"
			fi

			;;
		 "Cambiar descripcion") 
			read -p "Nuevo comentario para el usuario: " comment
			echo usermod -c "\" $comment\""
			;;
		"Cambiar directorio principal de un usuario")
			read -p "Ruta del directorio principal: " newDir
			if [[ -d "$newDir" || -e "$newDir" ]]; then
				echo "NO es un directorio o no existe"
				exit 1
			else
				echo usermod -d "$newDir" user
			fi
			;;
		 "Cambiar shell de un usuario")
			read -p "usuario a cambiar shell: " user
			uExist $user

			read -p "Seleccione una shell para el usuario: " newShell
			echo usermod -s "$(which $newShell)" "$user"
			;;
		"Bloquear cuenta") 
			read -p "Bloquear cuenta: " user
			uExist $user

			echo usermod -L "$user"

			;;
		"Desbloquear cuenta")
			read -p "Desbloquear cuenta: " user
			uExist $user

			echo usermod -U "$user"
			;;
		"Cambiar grupo primario")
			read -p "Usuario a cambiar grupo primario: " user
			uExist $user

			read -p "nuevo grupo principal: " pgroup
			if getent group | cut -d ":" -f 1 | grep "^$pgroup$" >/dev/null 2>&1; then
				echo usermod -g "$pgroup"
			fi
			;;
		 "Cambiar grupo secundario")
			read -p "Usuario a cambiar grupos secundarios: " user
			uExist $user

			uGmodify
			;;
		"Menu usuario")
			break;;
		*)
			echo "Opcion no encontrada"
			;;
		esac
	done
}

uGmodify(){

	groupsModify=()

	select var in "Agregar grupos secundarios" "Reasignar grupos secundarios"; do
		case $var in
			"Agregar grupos secundarios")
				while true; do
					read -p "Grupo secundario: " group
					gExist "$group"
					groupsModify+=("$group")

					read -p "Agregar mas grupos: y/n " opc
					if [[ "$opc" == "n" ]]; then
						break
					fi
				done
				echo usermod -aG "${groupsModify[*]}"
				;;
			 "Reasignar grupos secundarios")
				while true; do
                                        read -p "Grupos secundarios: " group
                                        gExist "$group"
                                        groupsModify+=("$group")

                                        read -p "Agregar mas grupos: y/n " opc
                                        if [[ "$opc" == "n" ]]; then
                                                break 
                                        fi
                                done
                                echo usermod -G "${groupsModify[*]}"
				;;
			*)
				echo "Opcion no encontrada"
				exit 1
				;;
		esac
	done

}

uExist(){
	if ! getent passwd | cut -d ":" -f 1 | grep "^$1$" >/dev/null 2>&1; then
        	echo "NO existe el usuario"
                exit
        fi
}

gExist(){
	 if ! getent group | cut -d ":" -f 1 | grep "^$1$" >/dev/null 2>&1; then
                echo "NO existe el usuario"
                exit
        fi
}

gCreate(){
#	groupArr+=("groupadd")

	read -p "Ingrese el nombre del grupo: " groupName
	#userArr+=("$groupName")

	read -p "Quiere asignar un GID al grupo? y/n: " opc

	if [[ "$opc" == "y" ]]; then
    		read -p "Ingrese el ID del grupo: " groupID
		if [[ $groupID -gt 0 && $groupID -lt 100 ]]; then
		        echo "Numeros reservados"
	        	exit 0
	        elif getent group $groupID > /dev/null 2>&1; then ####EXPLICAR
		        echo "El grupo ya existe"
	        else
		        groupArr+=("-g $groupID")
    		fi
	fi

	groupArr+=("$groupName")

	echo "groupadd ${groupArr[*]}"
	#echo "Definir password del grupo: "
	#gpasswd "$groupName"

}


gShow(){
	getent group	
}

groupDelete(){
	gShow
        read -p "ingrese el nombre del grupo para eliminar: " gname

        if getent group | grep "$gname" >/dev/null 2>&1 ; then
                echo groupdel "$gname"
        else
                echo "Grupo no encontrado"
                exit
        fi

}


groupModify(){
	select var in "Cambiar nombre" "Cambiar id"; do
		case $var in 
			"Cambiar nombre")
					gShow 
					read -p "Ingrese el nombre del grupo a cambiar: " nameOne
					read -p "Nuevo nombre del grupo $nameOne: " nameTwo

					if ! getent group | cut -d ":" -f 1 | grep "^$nameOne$"; then
						echo "El grupo $nameOne no existe "
						exit
					elif getent group | cut -d ":" -f 1 | grep "^"$nameTwo"$" > /dev/null 2>&1; then
						echo "El nuevo nombre $nameTwo ya existe"
						exit
					else
						echo groupmod -n "$nameTwo" "$nameOne"
					fi

					exit 0				
				;;

			"Cambiar id")
					gShow
					read -p "Ingrese el nombre del grupo a modificar [mayores que 1000] : " gname
					read -p "Ingrese nuevo GID del grupo: " gid
					
					if [[ $gid -lt 1000 ]]; then
						echo "Numeros reservados, debe ser mayor que 1000"
						exit 0 
					elif ! getent group | cut -d ":" -f 1 | grep "^$gname$"; then
						echo "El grupo no existe"
						exit
					else
						echo groupmod -g "$gid" "$gname"
					fi
				;;
			*)
				break
				;;
		esac 
	done	
}



arrGlobal=("Administrar usuarios" "Administrar Grupos")

select var in "${arrGlobal[@]}"; do
	case $var in
		"Administrar usuarios")
			user
			;;
		"Administrar Grupos")
			group
			;;
		*)
			;;
	esac 
done


 
