sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-17-jdk  wget -y
java -version
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.13.4-amd64.deb
sudo dpkg -i elasticsearch-8.13.4-amd64.deb
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.13.4-amd64.deb
sudo dpkg -i kibana-8.13.4-amd64.deb
sudo systemctl enable kibana
sudo systemctl start kibana
#http://localhost:5601
wget https://artifacts.elastic.co/downloads/logstash/logstash-8.13.4-amd64.deb
sudo dpkg -i logstash-8.13.4-amd64.deb
sudo systemctl enable logstash
sudo systemctl start logstash
/usr/share/logstash/bin/logstash --version
sudo /usr/share/logstash/bin/logstash --config.test_and_exit -f /etc/logstash/conf.d/
#sudo nano /etc/logstash/conf.d/test.conf
# Enable at boot
sudo systemctl enable elasticsearch
sudo systemctl enable kibana
sudo systemctl enable logstash

# Start services
sudo systemctl start elasticsearch
sudo systemctl start kibana
sudo systemctl start logstash
