#!/bin/bash

if [ ! -d /var/lib/mysql/dbception ]; then
    mysql_install_db --ldata=/var/lib/mysql/dbception

        echo "FLUSH PRIVILEGES;" > /tmp/grant.sql
        echo "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" >> /tmp/grant.sql
        echo "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';" >> /tmp/grant.sql
        echo "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';" >> /tmp/grant.sql
        echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASS}';" >> /tmp/grant.sql
        echo "FLUSH PRIVILEGES;" >> /tmp/grant.sql

    mysqld_safe --bootstrap --skip-networking=0 < /tmp/grant.sql
fi

exec mysqld_safe