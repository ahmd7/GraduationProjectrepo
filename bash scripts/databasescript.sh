#!/bin/bash
sudo apt update -y
sudo apt install mariadb-server mariadb-client -y
sudo systemctl start mariadb
#systemctl status mariadb#
#sudo mysql_secure_installation
#mysql -u root -p
#systemctl restart mariadb
#mysql
#Database commands
#CREATE DATABASE wordpress;
#CREATE USER "wordpress"@"IP_of_wordpress" identified by "password";
#GRANT ALL PRIVILEGES ON wordpress.* TO "wordpress"@"IP_of_wordpress";
#vim /etc/mysql/mariadb.conf.d/50-server.cnf 
#comment bind IP