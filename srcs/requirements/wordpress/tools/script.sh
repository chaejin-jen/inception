#!/bin/sh

sleep 5

until mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD 2> /dev/null ; do
    echo "waiting for MariaDB to be on..."
    sleep 4
done

# wp install, add defalut user, new user
echo "check wp installed..."
if ! [ -f "/var/www/html/wordpress/index.php" ]; then 
    wp core download --locale=en_US && \
    wp config create --dbname=$MYSQL_DATABASE --dbhost=$MYSQL_HOST --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD && \
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PW --admin_email=$WP_ADMIN_EMAIL && \
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS
fi
echo "wp setup!"

chown -R www-data:www-data /var/www/html

exec "$@"