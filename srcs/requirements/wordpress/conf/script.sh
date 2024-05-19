!bin/bash

sleep 10

wp config create --allow-root --dbname=$SQL_DATABASE
wp config create --allow-root --dbuser=$SQL_USER
wp config create --allow-root --dbpass=$SQL_PASSWORD 
wp config create --allow-root --dbhost=mariadb:3306 --path='/var/www/wordpress'
