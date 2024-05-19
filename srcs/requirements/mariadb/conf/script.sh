#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Starting temporary MariaDB server..."
    mysqld_safe --skip-networking &
    pid="$!"

    mysql=( mysql --protocol=socket -uroot )

    for i in {30..0}; do
        if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
            break
        fi
        echo 'MariaDB init process in progress...'
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    echo "Setting up MariaDB users and database..."
    "${mysql[@]}" <<-EOSQL
        FLUSH PRIVILEGES;
        CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';
        GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASS}';
        FLUSH PRIVILEGES;
EOSQL

    echo "Stopping temporary MariaDB server..."
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MariaDB server stop failed.'
        exit 1
    fi

    echo "MariaDB setup completed."
else
    echo "MariaDB data directory already exists. Skipping initialization."
fi

echo "Starting MariaDB server..."
exec mysqld_safe
