# Testplan

- Auteur(s) testplan: Armin en Renzo

## Test: De ingestelde VLAN's kunnen elkaar succesvol pingen

Testprocedure:

1. Controleer of de VLAN's correct zijn geconfigureerd op de netwerktoestellen
2. Zorg ervoor dat elk VLAN een uniek VLAN ID heeft
3. Zorg ervoor dat elk apparaat is toegewezen aan de juiste VLAN
4. Controleer of de IP-adressen van de apparaten binnen het juiste subnet van hun respectievelijke VLAN liggen
5. Selecteer een apparaat in VLAN X (vb. 12) en een ander in VLAN Y (vb. 13)
6. Vanaf het apparaat in VLAN X, ping het IP-adres van het apparaat in VLAN Y
7. Vanaf het apparaat in VLAN Y, ping het IP-adres van het apparaat in VLAN X
8. Controleer of de pingen tussen de VLAN's succesvol zijn
9. Zorg ervoor dat er geen pakketverlies is tijdens het pingen
10. Controleer de pingtijden om te bevestigen dat de latentie acceptabel is

Verwacht resultaat:

1. Pingen tussen VLAN's is succesvol en er is geen pakketverlies
2. Pingtijden zijn redelijk en duiden niet op problemen met de netwerkprestaties

Oplossing bij fouten:

1. Als pingen tussen VLAN's mislukt, controleer dan de VLAN-configuratie op de netwerktoestellen
2. Controleer de configuratie van IP-adressen en subnetten van de apparaten
3. Controleer of de juiste routing tussen VLAN's is geconfigureerd op de routers

## Test: De ingestelde VLAN's kunnen de ISP bereiken

Testprocedure:

1. Controleer of de VLAN's correct zijn geconfigureerd op de netwerktoestellen
2. Zorg ervoor dat de router correct is geconfigureerd met een gateway naar de ISP-router (192.168.101.254)
3. Selecteer een apparaat in een van de VLAN's
4. Open een opdrachtprompt op het geselecteerde apparaat
5. Voer het ping-commando uit om het IP-adres van de ISP-router te pingen (192.168.101.254)
6. Controleer of het ping-commando succesvol is en er geen pakketverlies optreedt
7. Herhaal dit voor elk van de andere VLAN's in het netwerk

Verwacht resultaat:

1. Pingen tussen VLAN's en ISP is succesvol en er is geen pakketverlies
2. Pingtijden zijn redelijk en duiden niet op problemen met de netwerkprestaties

Oplossing bij fouten:

1.  Als pingen tussen de VLAN's en ISP mislukt, controleer dan eerst de routerconfiguratie om er zeker van te zijn dat de juiste gateway is ingesteld voor verkeer naar de ISP
2.  Controleer vervolgens de VLAN-configuratie op de switches om ervoor te zorgen dat er geen VLAN-misconfiguraties zijn die de connectiviteit belemmeren
