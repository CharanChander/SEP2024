# Testplan

- Auteur(s): Renzo, Charan

## Test: Succesvolle deployment van linuxtoestellen via vagrant

Testprocedure: 

1. Controleer of Vagrant geïnstalleerd is op het hosttoestel en de beschikbaarheid van een Vagrantfile voor de gewenste configuratie
2. Navigeer naar de directory waar de Vagrantfile zich bevindt
3. Voer het commando 'vagrant up' uit om de virtuele machines te starten
4. Monitor de uitvoer om te controleren of het starten van virtuele machines zonder fouten verloopt
5. Monitor de uitvoer van de scripts.
6. Maak verbinding met de virtuele machines via SSH met het commando 'vagrant ssh <machine_naam> en controleer of de verbinding succesvol is
7. Controleer de IP adressen.
8. Controleer de default route
9. Stel de default route in voor inter-vlan verbinding.
10. Kijk na of de gewenste software en configuraties correct zijn geïnstalleerd op elke virtuele machine.

Verwachte Resultaten: 

1. Het commando 'vagrant up' wordt uitgevoerd zonder fouten
2. Alle virtuele machines worden correct gestart en zijn toegankelijk via SSH
3. Er verschijnen geen errors van de scripts.

Oplossing bij fouten:

1. Als er fouten optreden tijdens het opstarten van de virtuele machines, controleer dan de uitvoer van het 'vagrant up' commando en zoek naar specifieke foutmeldingen
2. Controleer de logbestanden van Vagrant en eventueel van VirtualBox om eventuele problemen te identificeren
3. Controleer de logbestanden van de service die het probleem geeft.
4. Controleer de configuratie van de Vagrantfile om mogelijke fouten in de configuratie te identificeren

## Test: Succesvolle implementatie testen van database server

Testprocedure: 

1. Het script is beschikbaar en de nodige toestemmingen om het script te implementeren zijn aanwezig
2. Voer het implementatiescript uit met behulp van het juiste commando
3. Controleer de uitvoer van het script op fouten of waarschuwingen
4. Verifieer dat het script geslaagd is zonder onderbrekingen
5. Bevestig de aanwezigheid van de database server zijn configuratiebestanden
6. Kijk of de status van de database server op actief staat
7. Checken of de database luistert op de ingestelde poort
8. Zorg ervoor dat de database enkel toegankelijk is via de webserver (192.168.101.193)
9. Controleer relevante logbestanden op fouten of waarschuwingen

Verwachte Resultaten:

1. Het implementatiescript wordt uitgevoerd zonder fouten
2. De database server is succesvol geïnstalleerd en geconfigureerd volgens de vereisten die wij hebben opgesteld
3. De database draait en luistert op de gespecificeerde poort

Oplossing bij fouten:

1. Controleer de logbestanden van de database server om specifieke foutmeldingen of uitzonderingen te identificeren
2. Controleer of de database server correct is geconfigureerd met de juiste poorten, authenticatiemethoden, ...
3. Controleer de firewall-instellingen op zowel de database server als eventuele tussenliggende firewalls om ervoor te zorgen dat de juiste poorten openstaan

## Test: Succesvolle implementatie testen van webserver

Testprocedure: 

1. Het script is beschikbaar en de nodige toestemmingen om het script te implementeren zijn aanwezig
2. Voer het implementatiescript uit met behulp van het juiste commando
3. Controleer de uitvoer van het script op fouten of waarschuwingen
4. Verifieer dat het script geslaagd is zonder onderbrekingen
5. Bevestig de aanwezigheid van de webserver zijn configuratiebestanden
6. Kijk of de status van de webserver op actief staat
7. Checken of de webserver luistert op de ingestelde poort
8. Test de webserverfunctionaliteit door toegang te krijgen to de standaardpagina via een webbrowser
9. Controleer relevante logbestanden op fouten of waarschuwingen

Verwachte Resultaten:

1. Het implementatiescript wordt uitgevoerd zonder fouten
2. De webserver is succesvol geïnstalleerd en geconfigureerd volgens de vereisten die wij hebben opgesteld
3. Het webserver-proces draait en luistert op de gespecificeerde poort
4. Toegang tot de standaardwebpagina via een webbrowser is mogelijk en toont de verwachte inhoud

Oplossing bij fouten:

1. Controleer de logbestanden van de webserver om specifieke foutmeldingen of uitzonderingen te identificeren
2. Controleer of de webserver correct is geconfigureerd met de juiste poorten, ...
3. Controleer de firewall-instellingen op zowel de webserver als eventuele tussenliggende firewalls om ervoor te zorgen dat de juiste poorten openstaan

## Test: Succesvolle implementatie testen van reverse proxy server

Testprocedure: 

1. Het script is beschikbaar en de nodige toestemmingen om het script te implementeren zijn aanwezig
2. Voer het implementatiescript uit met behulp van het juiste commando
3. Controleer de uitvoer van het script op fouten of waarschuwingen
4. Verifieer dat het script geslaagd is zonder onderbrekingen
5. Bevestig de aanwezigheid van de reverse proxy server zijn configuratiebestanden
6. Checken of de webserver luistert op de ingestelde poort
7. Test de connectiviteit met de reverse proxy server en verifieer of deze verzoeken doorstuurt naar de juiste backend servers
8. Controleer of de reverse proxy server correct omgaat met verschillende soorten verzoeken (HTTP, HTTPS)

Verwachte Resultaten:

1. Het implementatiescript wordt uitgevoerd zonder fouten
2. De reverse proxy server is succesvol geïnstalleerd en geconfigureerd volgens de vereisten die wij hebben opgesteld
3. Het reverse proxy server-proces draait en luistert op de gespecificeerde poort
4. Connectiviteit met de reverse proxy server is mogelijk en deze stuurt verzoeken correct door naar de juiste backend servers (Webserver)

Oplossing bij fouten:

1. Controleer de logbestanden van de reverse proxy server om specifieke foutmeldingen of uitzonderingen te identificeren
2. Controleer of de reverse proxy server correct is geconfigureerd met de juiste poorten, doorstuurregels, ...
3. Controleer de firewall-instellingen op zowel de reverse proxy server als eventuele tussenliggende firewalls om ervoor te zorgen dat de juiste poorten openstaan
   
## Test: Succesvolle implementatie testen van TFTP-server

Testprocedure:

1. Het script is beschikbaar en de nodige toestemmingen om het script te implementeren zijn aanwezig
2. Voer het implementatiescript uit met behulp van het juiste commando
3. Controleer de uitvoer van het script op fouten of waarschuwingen
4. Verifieer dat het script geslaagd is zonder onderbrekingen
5. Bevestig de aanwezigheid van de TFTP-server zijn configuratiebestanden
6. Kijk of de status van de TFTP-server op actief staat
7. Checken of de webserver luistert op de ingestelde poort (standaard 69)
8. Test de connectiviteit met de TFTP-server om te controleren of deze bereikbaar is vanaf andere virtuele machines in het netwerk
9. Voer een test uit door een bestand naar de TFTP-server te uploaden en vervolgens te downloaden om te controleren of de overdacht correct verloopt

Verwachte Resultaten:

1. Het implementatiescript wordt uitgevoerd zonder fouten
2. De TFTP-server is succesvol geïnstalleerd en geconfigureerd volgens de vereisten die wij hebben opgesteld
3. Het TFTP-server proces draait en luistert op de gespecificeerde poort (standaard 69)
4. Connectiviteit met de TFTP-server is mogelijk vanaf andere machines in het netwerk
5. Uploaden en downloaden van bestanden naar en van de TFTP-server verloopt zonder fouten

Oplossing bij fouten:

1. Controleer de logbestanden van de  TFTP-server om specifieke foutmeldingen of uitzonderingen te identificeren
2. Controleer of de TFTP-server correct is geconfigureerd met de juiste poorten, directories en permissies, ...
3. Controleer de firewall-instellingen op zowel de TFTP-server als eventuele tussenliggende firewalls om ervoor te zorgen dat de juiste poorten openstaan