$zone = "ad.go1-agilenet.internal"
$netID = "192.168.101.0/24"
$r_zone = "101.168.192.in-addr.arpa"

Remove-DnsServerZone $zone -Force 
Remove-DnsServerZone $r_zone -Force

Add-DnsServerPrimaryZone -Name $zone -ZoneFile "ad.go1-agilenet.internal.DNS"

Add-DnsServerPrimaryZone -NetworkID $netID -ReplicationScope "Forest"

#Voeg A-records toe
Add-DnsServerResourceRecordA -ZoneName $zone -Name "proxy" -IPv4Address "192.168.101.225"
Add-DnsServerResourceRecordA -ZoneName $zone -Name "client" -IPv4Address "192.168.101.10"

#Voeg PTR-records toe voor omgekeerde DNS-lookups
Add-DnsServerResourceRecordPtr -ZoneName "101.168.192.in-addr.arpa" -Name "225.101.168.192" -PtrDomainName "proxy.ad.go1-agilenet.internal"
Add-DnsServerResourceRecordPtr -ZoneName "101.168.192.in-addr.arpa" -Name "10.101.168.192" -PtrDomainName "client.ad.go1-agilenet.internal"

#Voeg optionele CNAME-records toe
Add-DnsServerResourceRecordCName -ZoneName "101.168.192.in-addr.arpa" -Name "www" -HostNameAlias "www.proxy.com"

#Stel forwarder in voor queries naar andere domeinen
Set-DnsServerForwarder -IPAddress 8.8.8.8 -Verbose