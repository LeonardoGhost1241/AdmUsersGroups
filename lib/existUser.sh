#!/bin/bash

# verify if a user exist

getent passwd "$1" >/dev/null
exist=$?


if [[ $exist -ne 0 ]]; then
    echo "[!] El usuario no existe"
fi




