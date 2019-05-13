#!/bin/bash

#une chaine de caractere vide
csv=""

#met le resultat du ping du site dans une variable 
#on prend que la partie qui contient "received"
pingResult=$(ping -c 1 carnofluxe.domain | grep -o "[0-1] received"|grep -o "[0-1]")

#si le résultat est un,ping réussi sinon échoué
if [[ "$pingResult" == 1 ]]; 
then
    #remplis la chaine du caractere 
	csv="$csv Le serveur HTTP est accessible"										
else
	csv="$csv Le serveur HTTP n'est pas accessible"									
fi

#met le resultat du dig  du site dans une variable 
#on prend que la partie ANSWER
digResult=$(dig carnofluxe.domain | grep  -Po 'ANSWER\:\s[0,1]')						

#si le résultat est ANSWER: 1,dig réussi sinon échoué
if [ "$digResult" == "ANSWER: 1" ]; then
        csv="$csv,le DNS est fonctionnel"					
else
        csv="$csv,Le DNS ne fonctionne pas"					
fi

# besoin d'installer curl
#met le resultat du curl du site dans une variable 
#on prend que la partie HTTP 200
curlCode=$(curl -I -s "carnofluxe.domain" | grep "HTTP" | grep -oP '\d{3}')		

#prend le temps du reponse de serveur et le mettre en variable
curlTime=$(curl -I -s -w "Total time: %{time_total}\n" "carnofluxe.domain" | grep "Total time:")				

#si le résultat est 200,curl réussi sinon échoué
if [ $curlCode == 200 ]; then
       csv="$csv,le site carnofluxe.domain est accessible,$curlTime"
else											
        csv="$csv,site carnofluxe.domain 'est pas accessible"
fi 		

#echo le resultat de notre test dans un fichier csv
echo "$csv" > /home/yacine/Desktop/httpstat.csv

#envoi le ficher csv a le serveur http
scp /home/yacine/Desktop/httpstat.csv root@192.168.10.10:/home/carnofluxe/csv/


