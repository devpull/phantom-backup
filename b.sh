#!/bin/bash
# !!! This file needs chmod 755 permissions


# log
# from: http://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>./logs/sh.log 2>&1


# conf
# after this command can use $PWD
cd "$(dirname "$0")"


BCK_DIR='/root/bck/kastrylki'
if [[ ! -d ${BCK_DIR} ]]; then mkdir ${BCK_DIR} ; fi


# vars
TIME=$(date +%H:%M)
DATE=$(date +%d%m%Y)
BCKFILE="${BCK_DIR}/kastrylki${DATE}.tar.gz"

# casperjs authenticate to ispmgr of hosting
#
# casper & phantom loggin in and getting the right number
#casperjs --cookies-file=$PWD/cookie.txt $PWD/casp.js

# on debian vps worked only with ignored ssl errors
casperjs --ignore-ssl-errors=true --ssl-protocol=any --cookies-file=cookie.txt casp.js
sleep 15


# clearing all except matched string
# matched auth token to separate file
sed -n 's/.*[ru|en]:\([0-9]*\).*/\1/p' $PWD/cookie.txt > $PWD/token.txt


# auth token check
# token: appletec ispmanager authentication token
TOKEN=$(<"$PWD/token.txt")
if [[ ${TOKEN} -eq 0 ]]; then
    echo "[$TIME] token is 0" >> "$PWD/logs/$DATE.log"
    exit
fi


#clearing bck directory
rm -rf ${BCK_DIR}/*

# downloading bck from ispmgr of hosting
#
curl -o "$BCKFILE" --limit-rate "3m" -Gvk -d plid="www" -d elid="kastrylki.ru" -d filename="/kastrylki.ru.tgz" -b "ispmgr4=sirius:ru:${TOKEN}" -H "Accept-Encoding: gzip, deflate,  sdch" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36" -H "Connection: keep-alive" -H "Accept: text/html,application/xht ml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" https://client.appletec.ru:1500/mancgi/download
