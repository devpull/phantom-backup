# Backup from ispmanager control panel

## Purpose of this
Hoster refused to provide daily backups and ftp access to them.
But it is possible to launch backup process from ispmanager-filemanager by GET.
Backuping from shared hosting by hands was not an option.  
CURL is not for javascript execution. For js execution using phantomjs and casperjs.

## Flow
1. Authorizing with phantomjs & casperjs
2. Receiving javascript produced cookie
3. CURL GET request using cookie

## Requirements (tested with phantomjs v1.9.8 & casperjs v1.1.0-beta3)
* phantomjs
* casperjs
* curl

## Setup
* Copy config.example.json to local/config.json and fill credentials.
* Set chmod 755 permissions for b.sh
* Set cron:

```
SHELL=/bin/bash  
MAILTO=mymail@some.mail  
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin  
   
0 0 * * * /root/phan_bck/b.sh
```