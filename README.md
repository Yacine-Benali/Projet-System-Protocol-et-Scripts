# Projet-System-Protocol-et-Scripts
this project is about setting up an HTTP web server two DNS master and slave and a webpage for the site carnofluxe.com,plus the scripts 

#### the bash scripts:

##### httpStat.sh: 
script that runs on the dns slave server and log information about status of the http server,the status of the dns server,and the status of the site carnofluxe.com and the time it takes to load it and send them to the http server

##### users.sh: 
this one runs on the http server and log the the ip adresse of the users that had access to the site and put it in a csv file 

##### webPageGenerator: 
this script runs every minut and generate the second site supervision.carnofluxe.com with the information from the two previous scripts note: this script require csv2html script to be downloaded

##### bscript: 
this one is a backup script that do full backup once a week and an incremental backup everyday
