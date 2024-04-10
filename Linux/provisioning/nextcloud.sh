#!/bin/bash
##https://www.howtoforge.com/the-ultimate-guide-to-installing-nextcloud-on-almalinux-step-by-step-tutorial/ 
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

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

echo "Firewall geïnstalleerd"

#----------------------------------------------------------------------------------------------------
# SSH
#----------------------------------------------------------------------------------------------------
if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

sudo systemctl restart sshd >/dev/null
echo "Root login disabled"

echo "Script succesvol afgerond"

#----------------------------------------------------------------------------------------------------
# Nextcloud
#----------------------------------------------------------------------------------------------------

sudo dnf install httpd -y

sudo systemctl start httpd
sudo systemctl enable httpd

echo "HTTPD geïnstalleerd"

sudo firewall-cmd --add-service={http,https} --permanent
sudo firewall-cmd --reload
echo "HTTP en HTTPS doorlaten op firewall"

sudo dnf install epel-release -y
sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
sudo dnf module reset php -y
sudo dnf module enable php:remi-8.1 -y

sudo dnf install php php-ctype php-curl php-gd php-iconv php-json php-libxml php-mbstring php-openssl php-posix php-session php-xml php-zip php-zlib php-pdo php-mysqlnd php-intl php-bcmath php-gmp php-imagick php-apcu -y
 

 ## Copie files for new config
sudo cp /vagrant/provisioning/files/nextcloud/php.ini /etc/php.ini
sudo cp /vagrant/provisioning/files/nextcloud/10-opcache.ini /etc/php.d/10-opcache.ini
sudo systemctl restart httpd
sudo systemctl restart php-fpm
