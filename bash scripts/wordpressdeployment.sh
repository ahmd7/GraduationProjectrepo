#!/bin/bash
sudo apt update -y
sudo apt install apache2 php wget unzip php-mysql php-cgi php-cli php-gd -y
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo cd wordpress/
sudo rm -rf /var/www/html
sudo sudo mkdir /var/www/html
sudo cp -r * /var/www/html
sudo cd /var/www/html/
sudo rm -rf index.html
sudo systemctl restart apache2
sudo chown -R www-data:www-data /var/www
sudo cp wp-config-sample.php wp-config.php
#change the parameters
sudo apt install mariadb-client mysql-server libapache2-mod-php -y
sudo systemctl restart apache2
#mysql
#Database commands
#CREATE DATABASE wordpress;
#CREATE USER "wordpress"@"%" identified by "password";
#GRANT ALL PRIVILEGES ON wordpress.* TO "wordpress"@"%";
