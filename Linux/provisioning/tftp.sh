#!/bin/bash
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

#-------------------------------------------------------------------------------------------->
# TFTP
#-------------------------------------------------------------------------------------------->
# Location of provisioning scripts and files
readonly PROVISIONING_SCRIPTS="/vagrant/provisioning/" >/dev/null
# Location of files to be copied to this server
readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/files/tftp/" >/dev/null

dnf install -y tftp-server tftp >/dev/null

cp /usr/lib/systemd/system/tftp.service /etc/systemd/system/tftp-server.service >/dev/null
cp /usr/lib/systemd/system/tftp.socket /etc/systemd/system/tftp-server.socket >/dev/null

cp "${PROVISIONING_FILES}"/tftp-server.service /etc/systemd/system/tftp-server.service >/dev/null

systemctl daemon-reload >/dev/null
systemctl enable tftp-server >/dev/null 2>&1
systemctl start tftp-server >/dev/null

echo "TFTP geïnstalleerd"

chmod 775 /var/lib/tftpboot >/dev/null

firewall-cmd --add-service=tftp --permanent >/dev/null
firewall-cmd --reload >/dev/null

echo "Firewall doorgelaten" 

sudo ip route delete default via 10.0.2.2

echo "NAT route verwijderd"

echo "Script succesvol afgerond"