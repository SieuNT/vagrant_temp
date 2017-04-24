#!/usr/bin/env bash

# Variables
DBHOST=localhost
DBNAME=cms
DBUSER=root
DBPASSWD=root

echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get -y install mysql-server

echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -u$DBUSER -p$DBPASSWD -e "CREATE DATABASE $DBNAME"
mysql -u$DBUSER -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'%' identified by '$DBPASSWD'"

echo -e "\n--- Installing PHP-specific packages ---\n"
apt-get -y install php apache2 libapache2-mod-php php-curl php-gd php-mysql 

echo -e "\n--- Enabling mod-rewrite ---\n"
a2enmod rewrite
echo -e "\n--- Allowing Apache override to all ---\n"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "\n--- Restarting Services ---\n"
service apache2 restart
service mysql restart

echo -e "\n--- Installing Composer for PHP package management ---\n"
curl --silent https://getcomposer.org/installer | php >> /vagrant/vm_build.log 2>&1
mv composer.phar /usr/local/bin/composer