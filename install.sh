#!/bin/bash
################################################################################
# echo wrappers
INFO(){ echo -n "INFO: "; echo "$@" ;}
WARN(){ echo -n "WARN: "; echo "$@" ;}
ERRO(){ echo -n "ERRO: "; echo -n "$@" ; echo " Abort!"; exit 1;}

PREFIX="/"
case $1 in
    PREFIX=*) PREFIX="${1//PREFIX=/}";;
esac

cd "$(dirname "$0")" || exit 1
if [ "$PREFIX" == "/" ]; then
    if [ "$UID" != "0" ]; then
        command -v sudo &> /dev/null || ERRO "Run by root or install sudo!"
        SUDO=sudo
    else
        unset SUDO
    fi
fi

$SUDO install -Dm644 ./leagueoflegends.conf     "$PREFIX/etc/leagueoflegends.conf"
$SUDO install -Dm755 ./leagueoflegends          "$PREFIX/usr/bin/leagueoflegends"
$SUDO install -Dm644 ./leagueoflegends.png      "$PREFIX/usr/share/icons/hicolor/256x256/apps/leagueoflegends.png"
$SUDO install -Dm644 ./leagueoflegends.desktop  "$PREFIX/usr/share/applications/leagueoflegends.desktop"
