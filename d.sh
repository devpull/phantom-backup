#!/usr/bin/env bash

# vars
TIME=$(date +%H:%M)
DATE=$(date +%d%m%Y)
BCKFILE="./kastrylki${DATE}.tar.gz"

# casper
casperjs --cookies-file=cookie.txt casp.js
sleep 15

# clearing all except matched string
# matched number to separate file
sed -n 's/.*[ru|en]:\([0-9]*\).*/\1/p' cookie.txt > 'numid.txt'
wait

TOKEN=$(<'numid.txt')

if [[ ${TOKEN} -eq 0 ]]; then
    echo "[$TIME] numid is 0" >> "~/bck/logs/$DATE.log"
    exit
fi

if [[ -e ${BCKFILE} ]]; then
    rm -rf ${BCKFILE}
fi

curl -o "$BCKFILE" --limit-rate "3m" -Gvk -d plid="www" -d elid="kastrylki.ru" -d filename="/kastrylki.ru.tgz" -b "ispmgr4=sirius:ru:${TOKEN}" -H "Accept-Encoding: gzip, deflate,  sdch" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36" -H "Connection: keep-alive" -H "Accept: text/html,application/xht ml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" https://client.appletec.ru:1500/mancgi/download