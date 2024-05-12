#!/bin/bash

#/etc/init.d/mariadb start OR service mariadb start ==> DONT WORK
chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql/

if [ ! -d /run/mysqld ]; then 
    mkdir -p /run/mysqld
fi

chown -R mysql:mysql /run/mysqld
chmod -R 755 /run/mysqld/

service mariadb start
sleep 5
exec mysqld_safe
# mysql_secure_installation

# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# mysql -e "$SQL_ROOT_PASSWORD"
# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"