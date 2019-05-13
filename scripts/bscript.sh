#!/bin/bash
#
# Backup script - Full and Incremental
# Version 0.8
# Created by LinuxStories
#
# For debug remove below hash
#set -x
#
#
DATA="/var/www"
LIST="/home/yacine/Desktop/backupbacklist_$$.txt"
DST="/home/yacine/Desktop/backup"
ERROR="/home/yacine/Desktop/backup/Error.log"
DAY=$(date +%a)


#
#
# here I am setting a time stamp variable which I like to use for logging
TIMESTAMP=`date +%Y%m%d.%H%M`

# let's create a variable for the backup file name file
FNAME="Backup"

# let's create a variable for the log file, let's also name the log file with the filename and timestamp it
LOG="/home/yacine/Desktop/backup/$FNAME-$TIMESTAMP.log"

#set $(date)
if [ $DAY = "Sun" ] ; then
        # weekly a full backup of all http data:
        #
        # start the backup, create a log file which will record any messages run by this script
        echo "*** Starting full backup -- $TIMESTAMP $DATA" >> ${LOG}
        tar cvfzP "$DST/data_full_$TIMESTAMP.tar.gz" $DATA >> ${LOG} 2> ${ERROR} 
        echo "*** Delete old full backup" >> ${LOG} 
        find $DST/ -mtime +4320 -exec rm {} \;	2> ${ERROR} 
        echo "*** Ending backup of $DATA directories -- $TIMESTAMP" >> ${LOG}
else
        # incremental backup:
        echo "*** Starting incremental backup -- $TIMESTAMP $DATA" >> ${LOG}
		#-depth proccess all the files one by one
		#-type f pour type de fichier
		#-mtime -1 pour les fihcier qui on ete modifier dans les 24h precedente
		find $DATA -depth -type f \(  -mtime -1 \) -print > $LIST 		2> ${ERROR} 	
        # start the backup, create a log file which will record any messages run by this script
      	tar cvfzTP  "$DST/data_incr_$TIMESTAMP.tar.gz" "$LIST" >> ${LOG} 2> ${ERROR} 	
		#delete the temp list
      	rm -f "$LIST" >> ${LOG} 										
        echo "*** Ending backup of $DATA directories -- $TIMESTAMP" >> ${LOG}
      
        echo "*** Ending backup of $CONFIG directories -- $TIMESTAMP" >> ${LOG}
fi

#End the backup, append to log file created by this script
echo "*** Ending total backup -- $TIMESTAMP ***" >> ${LOG}


#if there is an error in the log file notify the admin in the supervision site
if [ -s ${ERROR}  ]
then
       	echo ",le sauvgarde n'est pas fonctionnel verifier le fichier log" >> /home/carnofluxe/csv/httpstat.csv
else

        echo ",le sauvgarde est fonctionnel" >> /home/carnofluxe/csv/httpstat.csv
fi
