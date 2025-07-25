#!/bin/bash

# Update system and install Fail2Ban
sudo apt update && sudo apt install fail2ban -y

# Backup original jail.conf and create jail.local
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Configure basic SSH jail
sudo tee /etc/fail2ban/jail.d/ssh.local > /dev/null <<EOL
[sshd]
backend = systemd
enabled = true
#port = ssh
port  = 22
filter = sshd
#logpath = /var/log/auth.log
maxretry = 3
bantime = 600
findtime = 300
EOL

# Start and enable Fail2Ban service
sudo systemctl enable --now fail2ban

# Show status
sudo fail2ban-client status sshd
