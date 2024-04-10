# Installeer de DHCP-serverrol
Install-WindowsFeature -Name DHCP -IncludeManagementTools

#DHCP herstarten
Restart-Service dhcpserver

#DHCP server autoriseren binnen AD
Add-DhcpServerInDc -DnsName ad.go1-agilenet.internal -IPAddress 192.168.101.195

# Maak een nieuw DHCP-bereik aan
Add-DhcpServerv4Scope -Name "WINDOWS2022_DHCP_RANGE" -StartRange 192.168.101.1 -EndRange 192.168.101.101 -SubnetMask 255.255.255.128 -State Active

# Stel de standaardgateway in voor het DHCP-bereik (optioneel)
Set-DhcpServerv4OptionValue -ScopeId 192.168.101.0 -OptionId 3 -Value 192.168.101.126

# Stel de DNS-server in voor het DHCP-bereik (optioneel)
Set-DhcpServerv4OptionValue -ScopeId 192.168.101.0 -OptionId 6 -Value 192.168.101.195
