#!/bin/bash

# verify if a user exist

userExistCreate(){
    getent passwd "$1" >/dev/null
    exist=$?

    if [[ $exist -ne 0 ]]; then
        echo "[!] El usuario no existe"
        exit 1
    fi
}

userExistModify(){
    getent passwd "$1" >/dev/null
    exist=$?

    if [[ $exist -eq 0 ]]; then
        echo "[!] El usuario Ya existe"
        exit 1
    fi
}

#isRoot(){
#}




