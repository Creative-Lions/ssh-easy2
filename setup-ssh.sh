#!/bin/bash
cat > /root/.ssh/authorized_keys << 'KEYS'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoJ2gO85aEC2IeyTLEABzdE5RKZWI1itALqE4bcQisZ jhonatanpetronilho@gmail.com
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMT5f5jaZQF+1Caa0wFdqeFTZS8zlnsT3AbVo0sN1thZ coolify-gestao6
KEYS
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
sed -i '/^AuthenticationMethods /d' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
sed -i '/^AuthenticationMethods /d' /etc/ssh/sshd_config
grep -q 'PasswordAuthentication' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf || echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
systemctl restart ssh
echo "OK"
