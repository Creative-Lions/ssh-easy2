#!/bin/bash
cat > /root/.ssh/authorized_keys << 'KEYS'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoJ2gO85aEC2IeyTLEABzdE5RKZWI1itALqE4bcQisZ jhonatanpetronilho@gmail.com
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMT5f5jaZQF+1Caa0wFdqeFTZS8zlnsT3AbVo0sN1thZ coolify-gestao6
KEYS
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
for f in /etc/ssh/sshd_config /etc/ssh/sshd_config.d/60-cloudimg-settings.conf /etc/ssh/sshd_config.d/99-hardening.conf; do
  [ -f "$f" ] && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' "$f"
  [ -f "$f" ] && sed -i '/^AuthenticationMethods /d' "$f"
done
systemctl restart ssh
echo "OK"
