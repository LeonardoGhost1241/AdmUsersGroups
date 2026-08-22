#!/bin/bash



statusA(){
    status=$(passwd -S $userShow | cut -d " " -f 2)

    if [[ "$status" == "P" ]]; then
        echo "Password setted"
     elif [[ "$status" == "NP" ]]; then
        echo "No password"
     else
         echo "The account is Lock"
     fi
}


name="$1"
id_user=$(getent passwd | grep "^$1:*" | cut -d ":" -f 3)
id_group=$(getent passwd | grep "^$1:*" | cut -d ":" -f 4)
allGroups=$(groups $1 | cut -d ":" -f 2 | xargs)
dirUser=$(getent passwd | grep "^$1:*" | cut -d ":" -f 6) 
typeShell=$(getent passwd | grep "^$1:*" | cut -d ":" -f 7)
comments=$(getent passwd | grep "^$1:*" | cut -d ":" -f 5) 
accountStatus=$(statusA)
dateExpire=$(chage -l $1 | grep "Account expires" | cut -d ":" -f 2 | xargs)

