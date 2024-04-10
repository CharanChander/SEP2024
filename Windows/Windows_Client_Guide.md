# Windows Client Instellen
In deze gids wordt uitgelegd hoe je stap voor stap een Windows Client GUI via VboxManage en scripts kan opstellen voor het project SEP.
# Host PC
## VM aanmaken
### Navigeer naar de VboxManage map
```
cd C:\Program Files\Oracle\VirtualBox\
```
### VboxManage script uitvoeren

# Windows Client
Doorloop de installatie van de windows client zoals gewoonlijk.
## VboxGuestadditions
### VBoxGuestadditions CD toevoegen
Insert de guest additions via de gewoonlijke manier: Insert > insert VBoxGuestAdditions CD
### VboxGuestAdditions installeren
Naar de verkenner gaan en deze dan installeren 
## IP-adres (DHCP)
```
ipconfig /all --> kijken naar naam adapter
```
Ophalen interface:
```
$nic = Get-NetAdapter -Name "naam_adapter"
```
Verwijder oude gateway:
```
$nic | Remove-NetRoute -Confirm:$false
```
DHCP activeren:
```
$nic | Set-NetIpInterface -DHCP Enabled
```
DNS-servers instellen via DHCP (niet nodig):
```
$nic | Set-DnsClientServerAddress -ResetServerAddresses
```
```
ipconfig (/all)
ipconfig /release
ipconfig /renew
ipconfig (/all)
```
## IP-adres via DHCP niet mogelijk
Statisch IP-adres ingeven binnen range (ncpa.cpl):
IP-adres: 192.168.101.10
Subnetmask: 255.255.255.128
Default Gateway: 192.168.101.126
DNS-server: 192.168.101.195
## Installatie nodige tools (RSAT)
1. Eerst in instellingen de taal veranderen naar Nederlands (azerty)
2. In de zoekbalk "Apps en features" ingeven
3. "Optional features" indrukken
4. Dan de nodige RSAT-tools installeren (AD, DHCP, DNS, Group Policy's, Server Manager)
## Client toevoegen aan de AD
1. Navigeren naar instellingen > System > About
2. Klik op "Rename this PC (advanced)" > "Change"
3. Bij "Member of" vul je bij domain de domeinnaam in:
ad.go1-agilenet.internal
4. Hierbij moet ook het IP-adres van de DNS-server ingegeven worden
5. Virtuele machine moet nu opnieuw opstarten
6. Je kan nu bestaande gebruikers toevoegen op het inlogscherm:
Aministrator: AD\Administrator
Employer: AD\Renzo_P
Employee: AD\Wade_A
## DNS testen
Opvragen configuratie DNS:
```
Get-DnsClient -InterfaceAlias "naam_adapter"
```
## Group Policy's testen
- Windows-toets + R > gpedit.msc
- Server Manager > Tools > Group Policy Management
# Bewijzen dat gebruiker geen rechten heeft op shared folder
1. Open verkenner
2. Navigeer naar de locatie van de shared folder
3. Probeer toegang te krijgen door te dubbelklikken, als de gebruiker geen toegangsrechten heeft dan zou hij een foutmelding moeten ontvangen

- Alternatief:
    Open een cmd en typ "net use", dit geeft een lijst met alle actieve netwerkverbindingen inclusief de shared folders. Als de gebruiker geen toegangsrechten heeft tot de shared folder, zou deze niet moeten weergegeven worden in de lijst

