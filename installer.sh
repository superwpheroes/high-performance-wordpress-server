#!/bin/bash
sudo apt update -y
sudo apt install firewalld -y
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --zone=public --permanent --add-port=7080/tcp
firewall-cmd --reload
wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
sudo apt-get install lsphp74 -y
sudo apt install lsphp74-common lsphp74-curl lsphp74-imap lsphp74-json lsphp74-mysql lsphp74-opcache lsphp74-imagick lsphp74-memcached lsphp74-redis -y
sudo apt-get install openlitespeed -y
sudo mv /usr/local/lsws/Example /usr/local/lsws/high-performance-production-server
sudo /usr/local/lsws/bin/lswsctrl start
cd /tmp
git clone https://github.com/Softicious/high-performance-production-server.git
sudo cp high-performance-production-server/httpd_config.conf /usr/local/lsws/conf/
sudo mv /usr/local/lsws/conf/vhosts/Example/ /usr/local/lsws/conf/vhosts/high-performance-production-server/
sudo cp high-performance-production-server/vhconf.conf /usr/local/lsws/conf/vhosts/high-performance-production-server/
sudo /usr/local/lsws/bin/lswsctrl restart
sudo apt install redis -y
systemctl start redis-server
systemctl enable redis-server
cd /usr/local/lsws/
sudo chown -R nobody:nogroup /usr/local/lsws/high-performance-production-server/html
sudo find /usr/local/lsws/high-performance-production-server/html/ -type d -exec chmod 750 {} \;
sudo find /usr/local/lsws/high-performance-production-server/html/ -type f -exec chmod 640 {} \;
sudo chown -R nobody:nogroup /usr/local/lsws/high-performance-production-server/html
sudo /usr/local/lsws/admin/misc/admpass.sh
