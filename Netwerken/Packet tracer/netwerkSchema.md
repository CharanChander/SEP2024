# Adresseringstabel

## Ipv4

| Subnets                | Netwerkadres    | Subnetmask            | Range                             | Broadcastadres  | aantal Hosts |
| ---------------------- | --------------- | --------------------- | --------------------------------- | --------------- | ------------ |
| Vlan 11 (workstations) | 192.168.101.0   | /25 (255.255.255.128) | 192.168.101.1 - 192.168.101.126   | 192.168.101.127 | 126          |
| Vrij subnet            | 192.168.101.128 | /26 (255.255.255.192) | 192.168.101.129 - 192.168.101.190 | 192.168.101.191 | 62           |
| Vlan 42 (servers)      | 192.168.101.192 | /28 (255.255.255.240) | 192.168.101.193 - 192.168.101.206 | 192.168.101.207 | 14           |
| Vrij subnet            | 192.168.101.208 | /28 (255.255.255.240) | 192.168.101.209 - 192.168.101.222 | 192.168.101.223 | 14           |
| Vlan 13 (DMZ)          | 192.168.101.224 | /29 (255.255.255.248) | 192.168.101.225 - 192.168.101.230 | 192.168.101.231 | 6            |
| Vlan 1 (Management)    | 192.168.101.232 | /29 (255.255.255.248) | 192.168.101.233 - 192.168.101.238 | 192.168.101.239 | 6            |
| Vrij subnet            | 192.168.101.240 | /29 (255.255.255.248) | 192.168.101.241 - 192.168.101.246 | 192.168.101.247 | 6            |
| Vrij subnet            | 192.168.101.248 | /30 (255.255.255.252) | 192.168.101.249 - 192.168.101.250 | 192.168.101.251 | 2            |
| ISP                    | 192.168.101.252 | /30 (255.255.255.252) | 192.168.101.253 - 192.168.101.254 | 192.168.101.255 | 2            |

## Ipv6

| Subnets                | Netwerkadres           | Subnetmask | Range                                             | Broadcastadres          | aantal Hosts |
| ---------------------- | ---------------------- | ---------- | ------------------------------------------------- | ----------------------- | ------------ |
| Vlan 11 (workstations) | 2001:db8:abcd:101::    | /64        | 2001:db8:abcd:101::1- 2001:db8:abcd:101::7e       | 2001:db8:abcd:101::7f   | 126          |
| Vlan 42 (servers)      | 2001:db8:abcd:101:80:: | /64        | 2001:db8:abcd:101:80::1- 2001:db8:abcd:101:80::6  | 2001:db8:abcd:101:80::7 | 6            |
| Vlan 13 (DMZ)          | 2001:db8:abcd:101:88:: | /64        | 2001:db8:abcd:101:88::1- 2001:db8:abcd:101:88::6  | 2001:db8:abcd:101:88::7 | 6            |
| Vlan 1 (Management)    | 2001:db8:abcd:101:90:: | /64        | 2001:db8:abcd:101:90::1 - 2001:db8:abcd:101:90::2 | 2001:db8:abcd:101:90::3 | 4            |
| ISP                    |                        | /64        |                                                   |                         |              |

## Netwerkschema

| Toestellen  | Interface | IPv4 adres      | Subnetmask | Default Gateway |
| ----------- | --------- | --------------- | ---------- | --------------- |
| R1          | g0/1.11   | 192.168.101.126 | /25        |                 |
| R1          | g0/1.42   | 192.168.101.206 | /28        |                 |
| R1          | g0/1.13   | 192.168.101.230 | /29        |                 |
| R1          | g0/1.1    | 192.168.101.238 | /29        |                 |
| R1 (uplink) | g0/0      | 192.168.101.253 | /30        |                 |
| ISP         | g0/0      | 192.168.101.254 | /30        |                 |
| Proxy       |           | 192.168.101.225 | /29        | 192.168.101.230 |
| TFTP        |           | 192.168.101.235 | /29        | 192.168.101.238 |
| Database    |           | 192.168.101.193 | /28        | 192.168.101.206 |
| Webserver   |           | 192.168.101.194 | /28        | 192.168.101.206 |
| WinServer   |           | 192.168.101.195 | /28        | 192.168.101.206 |
| WinClient   |           | 192.168.101.10  | /25        | 192.168.101.126 |
| nextcloud   |           | 192.168.101.196  | /25        | 192.168.101.206 |
|             |           | 192.168.101.    | /          |                 |
| SVI 11      |           | 192.168.101.125 | /25        |                 |
| SVI 42      |           | 192.168.101.205 | /28        |                 |
| SVI 13      |           | 192.168.101.229 | /29        |                 |
| SVI 1       |           | 192.168.101.237 | /29        |                 |

## Static routes iteratie 1 (voor lectoren)

- `ip route 192.168.101.0 255.255.255.128  192.168.101.253`
- `ip route 192.168.101.192 255.255.255.240 192.168.101.253`
- `ip route 192.168.101.224 255.255.255.248 192.168.101.253`
- `ip route 192.168.101.232 255.255.255.248 192.168.101.253`

S1 ???
192.168.101.234/29