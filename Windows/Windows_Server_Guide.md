# Windows Server 2022 Installation Guide
In deze gids wordt uitgelegd hoe je stap voor stap een Windows Server 2022 CLI via VboxManage en scripts kan opstellen voor het project SEP.
# Host PC
## VM aanmaken
### Navigeer naar de VboxManage map
```
cd C:\Program Files\Oracle\VirtualBox\
```
### VboxManage script uitvoeren
```
VBoxManage createvm --name "WindowsServer2022" --ostype "Windows2016_64" --register
VBoxManage modifyvm "WindowsServer2022" --memory 2048 --nic1 nat
VBoxManage createhd --filename "C:\Users\louis\VirtualBox VMs\WindowsServer2022\WindowsServer2022.vdi" --size 20480
VBoxManage storagectl "WindowsServer2022" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "WindowsServer2022" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\Users\louis\VirtualBox VMs\WindowsServer2022\WindowsServer2022.vdi"
VBoxManage modifyvm "WindowsServer2022" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage storageattach "WindowsServer2022" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "C:\Users\louis\Downloads\en-us_windows_server_2022_x64_dvd_620d7eac.iso"
```
### Mapje scripts kopiëren naar Windows Server
 ```
VBoxManage guestcontrol "WindowsServer2022" copyto "C:\Users\louis\VirtualBox VMs\Scripts" "C:\Documents" --username Administrator --password Root123
 ```
# Windows Server
Doorloop de installatie van de windows server zoals gewoonlijk. Stel ook volgende gebruikersnaam en wachtwoord in:
- User = Administrator
- Password = Root123
## VboxGuestadditions
### VBoxGuestadditions CD toevoegen
Insert de guest additions via de gewoonlijke manier: Insert > insert VBoxGuestAdditions CD
### VboxGuestAdditions installeren
```
cd D:\
```
```
.\VboxWindowsAdditions.exe
```
## Installatie nodige tools
### DC maken van server
```
Install-ADDSForest -DomainName "go1-agilenet.internal" -DomainMode Win2012R2 -ForestMode Win2012R2 -InstallDns
```
De server moet heropgestart worden
### AD DS installeren
```
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
### DNS-server installeren
```
Install-WindowsFeature DNS -IncludeManagementTools
```
### IP-adres instellen
```
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "192.168.101.195" -PrefixLength "28" -DefaultGateway "192.168.101.206"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "xxx.xxx.xxx.xxx”
```
# Windows Server Scripts
Alle scripts bevinden zich in volgende map:
```
cd C:\Documents
```
## OU's
### OU's toevoegen
```
.\OU_Accounts.ps1
```
### OU's nakijken
```
Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Users,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal" | Select-Object Name, DistinguishedName
```
## Users
### Users toevoegen aan AD
```
.\Accounts_invoegen.ps1
```
### Users nakijken
```
Get-ADUser -Filter * -SearchBase "OU=Users,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal" | Select-Object Name, SamAccountName, DistinguishedName
```
## DNS
### DNS server instellen
```
.\DNS.ps1
```
### DNS server nakijken
```
Get-DnsServerResourceRecord -ZoneName "ad.go1-agilenet.internal"
```
```
Get-DnsServerResourceRecord -ZoneName "101.168.192.in-addr.arpa"
```
## DHCP
### DHCP server installeren en instellen
```
.\DHCP.ps1
```
### DHCP server nakijken
```
Eventuele controle van authorisatie:
Get-DhcpServerInDc
```
```
Ophalen Scope:
Get-DhcpServerv4OptionValue -ScopeId 192.168.101.0
```
```
Get-Service Dhcp
```
## Shared folder
### Shared folder aanmaken
```
.\Shared_Folder_Aanmaken.ps1
```
### Shared folder controleren
```

```
## Group Policy
### Group Policy instellen
```
.\Groepsbeleid_Aanmaken.ps1
```
### Group Policy nakijken
Voor het nakijken van de group policy zul je moeten inloggen via de Windows Client. Je logt 1 keer in met een 'Employee' account en 1 keer met een 'Employer' account. Je zou volgende output moeten krijgen:
- 'Employee' account: 
- 'Employer' account: 