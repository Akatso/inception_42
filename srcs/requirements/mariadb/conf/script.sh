#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    mysql -e "FLUSH PRIVILEGES;"
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';"
    mysql -e "ALTER USER 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASS}';"
    mysql -e "FLUSH PRIVILEGES;"
    sleep 5
    exec mysqld_safe

fi
echo "already done"
exec mysqld_safe