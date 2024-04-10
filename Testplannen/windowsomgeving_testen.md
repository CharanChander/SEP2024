# Testplan

- Auteur(s): Renzo

## Test: Succesvolle deployment van windowstoestellen via VBoxManage

Testprocedure:

1. VirtualBox is geïnstalleerd op de hostmachine en er is voldoende schijfruimte en systeembronnen beschikbaar
2. Open een opdrachtprompt op de hostmachine
3. Voer het VBoxManage-commando uit om een de virtuele machines te deployen met de gewenste configuratie en specificaties
4. Kijk naar de voortgang van het deploymentproces en wacht tot het voltooid is
5. Controleer of de virtuele machine correct is gemaakt en geconfigureerd zoals gespecificeerd
6. Start de virtuele machine en controleer of het besturingssysteem correct wordt geladen
7. Voer enkele basisbewerkingen uit en kijk of deze functionaliteiten deftig werken

Verwachte Resultaten:

1. Het deploymentproces start zonder fouten en wordt voltooid
2. De virtuele machine is correct aangemaakt en geconfigureerd volgens de specificaties
3. De virtuele machines worden zonder problemen geladen
4. Basisbewerkingen kunnen worden uitgevoerd op de virtuele machine zonder problemen

Oplossing bij fouten:

1. Als het deploymentproces fouten oplevert, controleer dan de juistheid van de opgegeven parameters en configuratiebestanden
2. Controleer of er voldoende schijfruimte en systeembronnen beschikbaar zijn op de hostmachine
3. Raadpleeg de logbestanden voor meer informatie over fouten en probeer het deploymentproces opnieuw uit te voeren na het oplossen van de gedetecteerde problemen

## Test: Succesvol opzetten van Active Directory Domain dat gecontroleerd wordt door een Domain Controller

Testprocedure:

1. Start de virtuele machine en zorg dat deze toegang heeft tot het internet en het lokale netwerk
2. Download en voer het Powershell-script uit dat is ontworpen om een nieuwe Domain Controller te maken en een Active Directory Domain op te zetten
3. Controleer de uitvoer van het script op eventuele fouten
4. Verifieer of de Domain Controller correct is geïnstalleerd en geconfigureerd
5. Maak een nieuwe Active Directory Forest met de gewenste domeinnaam
6. Voeg de OU's toe (zie verder) aan de domeinstructuur met behulp van Powershell
7. Controleer of deze succesvol zijn toegevoegd aan het domein
8. Voeg een Windows-client toe aan het domein aan de hand van het Powershell-script
9. Controleer of de Windows-client met succes is toegevoegd aan het Active Directory Domain

Verwachte Resultaten:

1. Het Powershell-script wordt zonder fouten uitgevoerd en voltooid
2. De Domain Controller wordt correct geïnstalleerd en geconfigureerd
3. Het Active Directory Forest wordt succesvol aangemaakt met de juiste domeinnaam
4. De OU's worden met succes toegevoegd aan de domeinstructuur
5. De Windows-client wordt met succes toegevoegd aan het Active Directory Domain

Oplossing bij fouten:

1. Als het Powershell-script fouten geeft, controleer dan de juistheid van de parameters
2. Controleer of de vereiste rechten en machtigingen correct zijn geconfigureerd voor het uitvoeren van het script
3. Kijk of alle vereiste services en afhankelijkheden correct zijn geïnstalleerd en geconfigureerd op de Domain Controller

## Test: Succesvol aanmaken van eigen containers binnen ons logisch domainstructuur

Testprocedure:

1. Start de virtuele machine en zorg ervoor dat deze toegang heeft tot het Active Directory Domain
2. Download en voer het Powershell-script uit dat de eigen containers (OU's) aanmaakt binnen de logische domainstructuur
3. Controleer de uitvoer van het script op eventuele fouten 
4. Verifieer of de eigen containers (OU's) correct zijn aangemaakt binnen het Active Directory Domain
5. Controleer of de aangemaakte containers (OU's) de juiste eigenschappen en machtigingen hebben zoals gespecificeerd (zie verder)

Verwachte Resultaten:

1. Het Powershell-script wordt zonder fouten uitgevoerd en voltooid
2. De eigen containers (OU's) worden correct aangemaakt binnen het Active Directory Domain
3. De aangemaakte containers (OU's) hebben de juiste eigenschappen en machtigingen zoals gespecificeerd

Oplossing bij fouten:

1. Als het Powershell-script fouten geeft, controleer dan de juistheid van de parameters
2. Controleer of de vereiste rechten en machtigingen correct zijn geconfigureerd voor het uitvoeren van het script
3. Kijk of alle vereiste services en afhankelijkheden correct zijn geïnstalleerd en geconfigureerd binnen het Active Directory Domain

## Test: Authenticatie van de gebruikers gebeurt via de Domain Controller

Testprocedure:

1. Start de virtuele machine en zorg ervoor dat deze verbonden is met het netwerk waar de Domain Controller zich bevindt
2. Meld een gebruiker aan met de gebruikersnaam en wachtwoord
3. Verifieer of de gebruiker correct wordt geathenticeerd door toegang te krijgen tot de services binnen het Active Directory Domain
4. Meld opnieuw aan, maar dan met een ongeldige gebruikersnaam of wachtwoord en verifieer dat de toegang wordt geweigerd
5. Herhaal deze stappen een paar keer opnieuw om de consistentie van de authenticatie te testen

Verwachte Resultaten:

1. Gebruikers kunnen succesvol worden geauthenticeerd via de Domain Controller op de virtuele machine met geldige gebruikersnamen en wachtwoorden
2. Toegang wordt geweigerd bij ongeldige gebruikersnamen of wachtwoorden 
3. De authenticatie is betrouwbaar

Oplossing bij fouten:

1.  Controleer of de juiste DNS-instellingen zijn geconfigureerd op de virtuele machine om de Domain Controller te vinden
2.  Controleer of de gebruikersaccounts correct zijn ingesteld en actief zijn in het Active Directory Domain

## Test: Gebruikers worden ingedeeld in groepen en hier staan dan Group Policy's op op de verschillende groepen

Testprocedure:

1. Start de virtuele machine en zorg ervoor dat deze verbonden is met het netwerk waar de Domain Controller zich bevindt
2. Meld verschillende gebruikers aan, die lid zijn van verschillende groepen binnen het Active Directory Domain
3. Verifieer welke Group Policy's worden toegepast op de gebruikers door het uitvoeren van het commando 'gpresult' in een opdrachtprompt in de virtuele machine
4. Check of de instellingen en configuraties van de toegepaste Group Policy's overeenkomen met de verwachte resultaten
5. Test de toegang tot verschillende services op basis van de toegepaste Group Policy's voor elke groep gebruikers

Verwachte Resultaten:

1. De gebruikers worden correct ingedeeld in groepen volgens de configuratie van het Active Directory Domain
2. De juiste Group Policy's worden toegepaste op de juiste groepen
3. De instellingen en configuraties van de toegepaste Group Policy's komen overeen met de verwachte resultaten
4. De toegang tot services wordt beheerd volgens de toegepaste Group Policy's voor elke groep gebruikers

Oplossing bij fouten:

1.  Als gebruikers niet correct worden ingedeeld in groepen, controleer dan de gebruikersinstellingen en groepsverdeling van de gebruikers in het Active Directory Domain
2.  Check of de Group Policy's correct zijn geconfigureerd en toegewezen aan de juiste groepen binnen het Active Directory Domain
3.  Zorg ervoor dat de virtuele machine correct is verbonden met het netwerk en toegang heeft tot de Domain Controller

## Test: Elke gebruiker heeft een shared folder op deze Domain Controller

Testprocedure:

1. Start de virtuele machine en zorg ervoor dat deze verbonden is met het netwerk waar de Domain Controller zich bevindt
2. Meld verschillende gebruikers aan met hun gebruikersnaam en wachtwoord
3. Verifieer of elke gebruiker toegang heeft tot hun toegewezen Shared Folder op de Domain Controller
4. Probeer bestanden te maken, bewerken en verwijderen binnen de toegewezen Shared Folder voor de gebruikers
5. Controleer de toegangsrechten van de Shared Folder om te verifiëren dat alleen de eigenaar van de map volledige controle heeft, terwijl andere gebruikers alleen lees- of schrijfrechten hebben

Verwachte Resultaten:

1. Elke gebruiker heeft correct toegang tot hun toegewezen Shared Folder op de Domain Controller
2. Gebruikers kunnen bestanden maken, bewerken en verwijderen binnen hun toegewezen Shared Folder
3. De toegangsrechten van de Shared Folders zijn geconfigureerd zoals verwacht, waarbij de eigenaar volledige controle heeft en andere gebruikers beperkte rechten hebben

Oplossing bij fouten:

1.  Als gebruikers geen toegang hebben tot hun toegewezen Shared Folder, controleer dan de rechten en machtigingen op de mappen
2.  Controleer de instellingen van de bestandstoegangsrechten op de Domain Controller
3.  Controleer of de gebruikers correct zijn toegevoegd

## Test: De Domain Controller is de DNS-server van het domain en kan alle queries binnen het domain beantwoorden

Testprocedure:

1. Start de virtuele machine en zorg ervoor dat deze verbonden is met het netwerk waar de Domain Controller zich bevindt
2. Voer het Powershell-script om de Domain Controller te configureren als DNS-server en om DNS-query's te testen binnen het domein
3. Controleer de uitvoer van het script op eventuele fouten
4. Voer DNS-query's uit binnen het domein en controleer of deze correct worden beantwoord door de Domain Controller
5. Test verschillende types DNS-query's (A-records, PTR-records en CNAME-records) om de functionaliteit van de DNS-server volledig te verifiëren

Verwachte Resultaten:

1. Het Powershell-script wordt zonder fouten uitgevoerd en voltooid
2. De Domain Controller wordt correct geconfigureerd als DNS-server
3. Alle DNS-query's binnen het domein worden correct beantwoord door de Domain Controller
4. De verschillende typen worden correct verwerkt en beantwoord

Oplossing bij fouten:

1.  Als het Powershell-script fouten geeft, controleer dan de juistheid van de parameters 
2.  Controleer of de vereiste rechten en machtigingen correct zijn geconfigureerd voor het uitvoeren van het script
