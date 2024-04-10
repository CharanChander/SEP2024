# Stappenplan basis iteratie

## Installatie kabels

- geen problemen mee gehad

## IP-adres geven aan router en switch

- checken van start-config: `show start` (anders `write erase`)
- int g0/0/1
- ip add 192.168.101.233 255.255.255.248
- no shut
- int g0/0/0
- ip add 192.168.101.253 255.255.255.252
- no shut
- `ip tftp source-interface g0/0/1` (in config)
- controle: `show ip interface brief`
- dhcp: int g0/0/0/1.11, ip helper-address 192.168.101.195 (in config pt geplaatst)

- op switch:
  - `int vlan 1`
  - `ip add 192.168.101.234 255.255.255.248`

## TFTP-server opzetten (kabel op patchpanel!!)

- tftp VM in brigded mode zetten (in virtualbox)
- correcte NIC aansluiten!!
- wifi afzetten!!
- vagrant up tftp
- DGW instellen (.238)
- ping 192.168.101.233 (controle connectie router)
- kopieer beide configfiles naar /var/lib/tftpboot
  - sudo cp * /var/lib/tftpboot

- copy tftp run: 192.168.101.235, CONFIGFILE (op router en switch)

- namen aanpassen van vlan's op switch (vlan 11, name workstations; vlan 13, name DMZ; vlan 42, name servers)

## Tips

### Default gateway wipen

- show ip route
- sudo ip route delete default via 10.0.2.2

### Switch wipen

- dir flash:
- delete flash:vlan.dat
- write erase
- reload

### Default gateway servers toevoegen

- sudo nmtui (DGW: .238)

### Selinux checken (enforcing)

- getenforce
- setenforce enforcing
