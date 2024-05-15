#!/bin/bash

/etc/init.d/mariadb start
# service mariadb start

mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';"
mysql -e -u root "ALTER USER 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASS}';"
mysql -e "FLUSH PRIVILEGES;"
sleep 5
service mariadb stop
exec mysqld_safe