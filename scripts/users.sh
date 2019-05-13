#!/bin/bash

#----THIS SCRIPT WAS CREATED BY Benali Mohammed Yacine

#mettre le temps dans une variable
timeNow="[$(date +%d/%b/%Y:%H:%M:%S)"

#heur -1
hour=$(( $(date +%H) - 1 ))
hour=$(printf  "%02d" $hour)

#formuler le temps depuis une heure
timeSinceAnHour="[$(date +%d/%b/%Y:)$hour:$(date +%M:%S)"

#ajoute une ligne a notre fichier csv
echo "IP,Time" > /home/carnofluxe/csv/users.csv

#apache log files is at /var/log/apache2/access.log
#uniq pour éviter les lignes identiques
#awk pour filter le fichier log 
#awk print pour afficher seulement les deux parametre (l'adress et le temp)
cat /var/log/apache2/access.log | uniq |awk -v timeNow="${timeSinceAnHour}" -v timeSinceAnHour="${timeNow}"  '$4 >= timeNow && $4 < timeSinceAnHour' | awk '{print $1 "," $4 "]"}' >> /home/carnofluxe/csv/users.csv

