#!/bin/bash
# Adiciona chaves (não sobrescreve)
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoJ2gO85aEC2IeyTLEABzdE5RKZWI1itALqE4bcQisZ jhonatanpetronilho@gmail.com" >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
for f in /etc/ssh/sshd_config /etc/ssh/sshd_config.d/60-cloudimg-settings.conf /etc/ssh/sshd_config.d/99-hardening.conf; do
  [ -f "$f" ] && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' "$f"
  [ -f "$f" ] && sed -i '/^AuthenticationMethods /d' "$f"
done
# Remove duplicatas do authorized_keys
sort -u /root/.ssh/authorized_keys > /tmp/auth_keys && mv /tmp/auth_keys /root/.ssh/authorized_keys
systemctl restart ssh
echo "OK"
