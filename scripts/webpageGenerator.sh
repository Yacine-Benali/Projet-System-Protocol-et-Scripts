#!/bin/bash

#----THIS SCRIPT WAS CREATED BY Benali Mohammed Yacine

#variable PATH pour que notre script l'utilise
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#notre fichier index.html pour la page web
index=/var/www/supervision.carnofluxe.domain/public_html/index.html

#style.txt contien CSS pour notre page
CSS=/home/carnofluxe/csv/style.txt

#mettre le css dans la page 
cat CSS > index

#transformer les fichiers csv en HTML et le mettre dans notre page
csv2html /home/carnofluxe/csv/httpstat.csv >> index
csv2html /home/carnofluxe/csv/users.csv >> index

#attribut pour la fin de la page html
echo "</body> </html>" >> index

