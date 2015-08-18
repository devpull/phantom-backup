# Backup from ispmanager control panel
---

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

## Usage
```casperjs --cookies-file=cookie.txt casp.js```