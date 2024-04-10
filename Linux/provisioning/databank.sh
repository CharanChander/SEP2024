#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Toetsenbord omzetten naar AZERTY
sudo loadkeys be >/dev/null

# nano installeren
sudo dnf install nano -y >/dev/null

# Variale ip adres webserver
IP_WEB=192.168.101.194

#----------------------------------------------------------------------------------------------------
# Firewall
#----------------------------------------------------------------------------------------------------
sudo dnf install firewalld -y >/dev/null

# Firewall starten
sudo systemctl start firewalld >/dev/null

echo "Firewall geïnstalleerd"

# Custom regels toevoegen zodat enkel wordpress binnenkan
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address='$IP_WEB' port port="3306" protocol="tcp" accept' >/dev/null

# Alle andere regels verwijderen
sudo firewall-cmd --zone=public --remove-service=cockpit --permanent >/dev/null
sudo firewall-cmd --zone=public --remove-service=dhcpv6-client --permanent >/dev/null

echo "Firewall doorgelaten"

# Firewall herstarten
sudo systemctl reload firewalld >/dev/null

# Firewall automatisch laten opstarten
sudo systemctl enable firewalld >/dev/null 2>&1

#----------------------------------------------------------------------------------------------------
# SSH
#----------------------------------------------------------------------------------------------------
if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

sudo systemctl restart sshd >/dev/null
echo "Root login disabled"

#----------------------------------------------------------------------------------------------------
# MariaDB
#----------------------------------------------------------------------------------------------------

# MariaDB installeren
sudo dnf install mariadb-server mariadb -y >/dev/null

# MariaDB starten en automatisch laten starten
sudo systemctl start mariadb >/dev/null
sudo systemctl enable mariadb >/dev/null 2>&1

# Inloggen op database
# ww is leeg
sudo mysql -u root<< EOF
CREATE DATABASE wordpress_db;
CREATE USER 'wordpress_user'@'$IP_WEB' IDENTIFIED BY 'DB_password';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'$IP_WEB';
FLUSH PRIVILEGES;
exit
EOF

echo "Database geïnstalleerd en geconfigureerd"

sudo ip route delete default via 10.0.2.2
echo "NAT route verwijderd"

echo "Script succesvol afgerond"