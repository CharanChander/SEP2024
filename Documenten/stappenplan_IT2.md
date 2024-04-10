# Stappenplan iteratie 2

## NAT

### Configureren van de uplink-interface

```ios
interface GigabitEthernet0/0 
description Verbinding met leslokaalnetwerk
ip address dhcp
```

### Configureren van NAT

`
ip nat inside source list 1 interface GigabitEthernet0/0 overload
`

### Toewijzen van NAT-acl

`
access-list 1 permit 192.168.101.0
`

### Toewijzen van het buiteninterface

```ios
interface GigabitEthernet0/0
description Verbinding met leslokaalnetwerk
ip nat outside
```

## ACL

```ios
access-list 101 permit ip 192.168.101.0 0.0.0.127 192.168.101.192 0.0.0.15   ! Toegang tussen Windows hosts en servers
access-list 101 permit ip 192.168.101.192 0.0.0.15 192.168.101.0 0.0.0.127   ! Terugverkeer van servers naar Windows hosts
access-list 101 permit tcp 192.168.101.192 0.0.0.15 192.168.101.224 0.0.0.7 eq 80   ! Toegang van webserver naar proxy (poort 80)
access-list 101 permit tcp 192.168.101.224 0.0.0.7 192.168.101.192 0.0.0.15 eq 443   ! Terugverkeer van proxy naar webserver (poort 443)
access-list 101 permit tcp 192.168.101.224 0.0.0.7 192.168.101.192 0.0.0.15 eq 1433   ! Toegang van database server naar Windows servers (poort 1433)
access-list 101 permit tcp 192.168.101.192 0.0.0.15 192.168.101.224 0.0.0.7 eq 1433   ! Terugverkeer van Windows servers naar database server (poort 1433)
access-list 101 permit ip 192.168.101.232 0.0.0.7 192.168.101.192 0.0.0.15   ! Toegang van management VLAN naar Windows servers
access-list 101 permit ip 192.168.101.192 0.0.0.15 192.168.101.232 0.0.0.7   ! Terugverkeer van Windows servers naar management VLAN
access-list 101 deny ip any any   ! Standaard alles weigeren behalve wat expliciet is toegestaan hierboven

interface GigabitEthernet0/1   ! Doe voor alle subnets van G0/1
description Verbinding met de subnetten
ip access-group 101 in
```
