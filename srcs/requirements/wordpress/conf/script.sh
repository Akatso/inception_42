#!/bin/bash

sleep 10

wp core download --allow-root
wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASS --dbhost=mariadb:3306 --skip-check
wp core install --allow-root --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
wp user create --allow-root $WP_USER $WP_EMAIL --user-pass=$WP_PASS

exec /usr/sbin/php-fpm7.3 -F
