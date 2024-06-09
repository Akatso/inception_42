#!/bin/bash

sleep 30

	wp core download --allow-root
	wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASS --dbhost=$DB_HOST --skip-check
	wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $WP_USER $WP_EMAIL --user_pass=$WP_PASS --role='contributor'

exec /usr/sbin/php-fpm7.4 -F
