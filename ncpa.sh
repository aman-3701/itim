#!/bin/bash
wget https://assets.nagios.com/downloads/ncpa/ncpa-latest.amd64.deb
sudo dpkg -i ncpa-latest.amd64.deb
sudo systemctl start ncpa_listener
sudo systemctl enable ncpa_listener
#sudo nano /usr/local/ncpa/etc/ncpa.cfg
sudo systemctl start ncpa_passive
sudo systemctl enable ncpa_passive
sudo systemctl status ncpa_listener
#After changing
sudo systemctl restart ncpa_listener
