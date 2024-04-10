#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Wordpress variabelen
IP_WEB=192.168.101.194
IP_PROX=192.168.101.225
DOCUMENT_ROOT=/var/www/html
ERROR_LOG=/var/log/httpd/wordpress_error.log
ACCESS_LOG=/var/log/httpd/wordpress_access.log

# Toetsenbord omzetten naar AZERTY
sudo loadkeys be >/dev/null

# nano installeren
sudo dnf install nano -y >/dev/null

#----------------------------------------------------------------------------------------------------
# Firewall
#----------------------------------------------------------------------------------------------------
sudo dnf install firewalld -y >/dev/null

# Firewall starten
sudo systemctl start firewalld >/dev/null

# Firewall automatisch laten opstarten
sudo systemctl enable firewalld >/dev/null 2>&1

# Enkel proxy toelaten
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address='$IP_PROX' port port="80" protocol="tcp" accept' >/dev/null

echo "Firewall geïnstalleerd"

#----------------------------------------------------------------------------------------------------
# SSH
#----------------------------------------------------------------------------------------------------
if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

sudo systemctl restart sshd >/dev/null
echo "Root login disabled"

#----------------------------------------------------------------------------------------------------
# Apache
#----------------------------------------------------------------------------------------------------
sudo dnf install httpd -y >/dev/null

# Service starten
sudo systemctl start httpd >/dev/null

# Starten op boot
sudo systemctl enable httpd >/dev/null 2>&1

echo "Apache geïnstalleerd"

# http(s) door de firewall laten
sudo firewall-cmd --permanent --zone=public --add-service=http >/dev/null
sudo firewall-cmd --permanent --zone=public --add-service=https >/dev/null

# Firewall reloaden
sudo systemctl reload firewalld >/dev/null

echo "Firewall doorgelaten"

#----------------------------------------------------------------------------------------------------
# PHP met extensions Installeren
#----------------------------------------------------------------------------------------------------
# Extra packages EPEL installeren
sudo dnf install epel-release -y >/dev/null

# PHP en extra packages installeren
sudo dnf install php php-curl php-bcmath php-gd php-soap php-zip php-mbstring php-mysqlnd php-xml php-intl php-zip -y >/dev/null

# PHP Controleren
if php -v >/dev/null; then
    echo "PHP geïnstalleerd en gevalideerd"
else
    echo "PHP geïnstalleerd maar niet gevalideerd"
fi

#----------------------------------------------------------------------------------------------------
# Wordpress
#----------------------------------------------------------------------------------------------------
# Package downloaden
sudo wget https://wordpress.org/latest.tar.gz >/dev/null 2>&1

# Bestand uitpakken
sudo tar -xvzf latest.tar.gz >/dev/null

echo "Wordpress geïnstalleerd"

# Verplaats bestanden naar webroot directory
sudo mv wordpress/* /var/www/html/ >/dev/null

# Apache rechten geven tot de wordpress map
sudo chown -R apache:apache /var/www/html/ >/dev/null

# SELinux toelaten
sudo chcon -t httpd_sys_rw_content_t /var/www/html/ -R >/dev/null
sudo restorecon -Rv /var/www/html/ >/dev/null

# Apache bestand aanmaken en invullen
cat <<EOF > /etc/httpd/conf.d/wordpress.conf
<VirtualHost *:80>
    ServerName $IP_WEB
    DocumentRoot $DOCUMENT_ROOT

    <Directory $DOCUMENT_ROOT>
        Options FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog $ERROR_LOG
    CustomLog $ACCESS_LOG combined
</VirtualHost>
EOF

# HTTP/2 Aanvaarden
echo 'Protocols h2 h2c http/1.1
<IfModule mod_setenvif.c>
SetEnvIf X-Forwarded-Proto "^https$" HTTPS
</IfModule>' >> /etc/httpd/conf/httpd.conf


# ServerTokens en ServerName toevoegen aan config.
sudo sed -i 's/^#*ServerTokens .*/ServerTokens Prod/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/^#*ServerName .*/ServerName ad.g01-agilenet.internal/' /etc/httpd/conf/httpd.conf

# Apache syntax controleren
if sudo apachectl configtest >/dev/null; then
    echo "Apache syntax OK"
else
    echo "Apache syntak NIET OK"
fi

#----------------------------------------------------------------------------------------------------
# Apache herstarten
#----------------------------------------------------------------------------------------------------
sudo systemctl restart httpd >/dev/null

sudo ip route delete default via 10.0.2.2
echo "NAT route verwijderd"

echo "Script succesvol afgerond"