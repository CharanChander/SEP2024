#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Variabelen proxy
IP_PROX=192.168.101.225
IP_WEB=http://192.168.101.194

# Toetsenbord omzetten naar AZERTY
sudo loadkeys be >/dev/null

# nano installeren
sudo dnf install nano -y >/dev/null
# EPEL Repo toevoegen
sudo dnf install -y epel-release >/dev/null

#----------------------------------------------------------------------------------------------------
# Firewall
#----------------------------------------------------------------------------------------------------
sudo dnf install firewalld -y >/dev/null

# Firewall starten
sudo systemctl start firewalld >/dev/null

# Firewall automatisch laten opstarten
sudo systemctl enable firewalld >/dev/null 2>&1

# HTTP en HTTPS doorlaten
sudo firewall-cmd --permanent --zone=public --add-service=http >/dev/null
sudo firewall-cmd --permanent --zone=public --add-service=https >/dev/null

# Firewall reloaden
sudo systemctl reload firewalld >/dev/null

echo "Firewall geïnstalleerd"

#----------------------------------------------------------------------------------------------------
# SSH
#----------------------------------------------------------------------------------------------------
if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

sudo systemctl restart sshd >/dev/null
echo "Root login disabled"

#---------------------------------------------------------------------------------------------------
# Certificaten
#---------------------------------------------------------------------------------------------------
# Certbot installeren
sudo dnf install certbot python3-certbot-nginx -y >/dev/null

# Certificaat aanvragen
# sudo certbot --nginx --non-interactive --agree-tos --email charan.chander@student.hogent.be -d ad.go1-agilenet.internal,www.ad.go1-agilenet.internal >/dev/null

#----------------------------------------------------------------------------------------------------
# Nginx
#----------------------------------------------------------------------------------------------------
# Nginx installeren
sudo dnf install nginx -y >/dev/null

# Nginx starten en automatisch laten starten
sudo systemctl start nginx >/dev/null
sudo systemctl enable nginx >/dev/null 2>&1

# Nginx configuratie aanpassen, voor https: ssl en http2 achter 80 zetten
cat <<EOF > /etc/nginx/conf.d/g01.conf
server {
    listen 80;
    server_name $IP_PROX;

    location / {
        proxy_pass $IP_WEB;
    }
}
EOF

# Syntax controleren
if sudo nginx -t >/dev/null 2>&1; then
    echo "Nginx geïnstalleerd en geconfigureerd"
else
    echo "Nging geïnstalleerd, fout met configuratie"
fi

# Nginx herstarten
sudo systemctl reload nginx >/dev/null

# NAT Route verwijderen
sudo ip route delete default via 10.0.2.2
echo "NAT route verwijderd"

echo "Script succesvol afgerond"