#!/bin/bash

until mysql -hmariadb -u$SQL_USER -p$SQL_PASS -e "SHOW DATABASES;" > /dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 3
done

if ! $(wp core is-installed --path=/var/www/wordpress); then
  wp config create --path=/var/www/wordpress --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASS --dbhost=mariadb --skip-check
  wp core install --path=/var/www/wordpress --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL
fi

exec php-fpm7.3 -F

