# AdmUsersGroups
Script de creacion de usuarios y grupos en bash 

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
