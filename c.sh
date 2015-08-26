#!/bin/bash

rmdir -rf cyp
mkdir cyp

# ls -p | grep -v /

openssl smime -encrypt -aes256 -in secret.txt -binary -outform DEM -out secret.txt.enc bckpub.pem
