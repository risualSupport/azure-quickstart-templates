#!/bin/bash

echo "Updating mysql configs in /etc/mysql/mysql.conf.d/mysqld.cnf."
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "Updated mysql bind address in /etc/mysql/mysql.conf.d/mysqld.cnf to 0.0.0.0 to allow external connections."

echo "Assigning mysql user user1 access on %."
sudo mysql --execute "GRANT ALL PRIVILEGES ON *.* TO root@'%'; FLUSH PRIVILEGES;"
echo "Assigned mysql user root access on all hosts."

echo "Adding Firewall Rule"
sudo ufw allow mysql
sudo service ufw restart
echo "Firewall Rule Added"

sudo service mysql stop
sudo service mysql start
