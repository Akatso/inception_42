#!bin/bash

sleep 10

# ????????????????????????
wp config create --allow-root
wp config create --dbname=$SQL_DATABASE
wp config create --dbuser=$SQL_USER
wp config create --dbpass=$SQL_PASSWORD 
wp config create --dbhost=mariadb:3306 --path='/var/www/wordpress'