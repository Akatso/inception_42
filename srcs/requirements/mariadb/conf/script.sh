!/bin/bash

if [ ! -d /var/lib/mysql/dbceeption ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=$SQL_USER --ldata=/var/lib/mysql/dbception

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
        CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;
        CREATE USER IF NOT EXISTS $SQL_USER IDENTIFIED BY '$SQL_PASS';
        GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';
        FLUSH PRIVILEGES;
EOSQL

    echo "Stopping temporary MariaDB server..."
    kill $(cat /var/run/mysqld/mysqld.pid)
fi

mysqld --bind-address=0.0.0.0