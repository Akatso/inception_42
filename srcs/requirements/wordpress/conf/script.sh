#!/bin/bash

wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASS --dbhost=mariadb:3306 --path='/var/www/wordpress'
wp core install --url=slepetit.42.fr --title=test --admin_user=superslep --admin_password=supergateau --admin_email=superslep@test.fr

exec /usr/sbin/php-fpm7.3 -F
