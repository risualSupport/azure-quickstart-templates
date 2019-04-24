#!/bin/bash

echo "Updating mysql configs in /etc/mysql/mysql.conf.d/mysqld.cnf."
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "Updated mysql bind address in /etc/mysql/mysql.conf.d/mysqld.cnf to 0.0.0.0 to allow external connections."

echo "Assigning mysql user root + migrate access on %."
sudo mysql --execute "GRANT ALL PRIVILEGES ON *.* TO root@'%'; FLUSH PRIVILEGES;"
sudo mysql --execute "GRANT ALL PRIVILEGES ON *.* TO migrate@'%' IDENTIFIED BY 'MIGRATEPASS'; FLUSH PRIVILEGES;"
sudo mysql --execute "GRANT ALL PRIVILEGES ON *.* TO edxapp001@'%' IDENTIFIED BY 'EDXAPPPASS'; FLUSH PRIVILEGES;"
echo "Assigned mysql user root access on all hosts."

echo "Adding Firewall Rule"
sudo ufw allow mysql
sudo service ufw restart
echo "Firewall Rule Added"

sudo service mysql stop
sudo service mysql start
