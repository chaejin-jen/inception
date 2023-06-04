#!/bin/sh

sleep 5

until mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD 2> /dev/null ; do
      echo "waiting for MariaDB to be on..."
      sleep 2
done


echo "check wp installed..."
# wp install, add defalut user, new user
if ! [ -f "/var/www/html/wordpress/index.php" ]; then 
    echo "wp installing..." && \
    wp core download --locale=en_US && \
    echo "set wp config..." && \
    wp config create --dbname=$MYSQL_DATABASE --dbhost=$MYSQL_HOST --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD && \
    echo "install wp core..." && \
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PW --admin_email=$WP_EMAIL && \
    echo "create wp user..." && \
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS && \
    touch ./.wp.setup.ok  && \
    echo "wp setup!"
fi
echo "wp OK!"

chown -R www-data:www-data /var/www/html

# 이상의 명령을 sh에서 www-data 유저로 수행 (sudo -u [유저명] sh -c)
# wp core download: 워드프레스 파일을 서버에서 다운로드 (내려받기만)
# wp config create: wp-config.php 파일 생성
# wp core install: 다운로드한 워드프레스 파일과 위에서 설정한 config 파일을 바탕으로 워드프레스 설치 및 설정
# wp user create: 워드프레스 유저 생성 https://developer.wordpress.org/cli/commands/user/create/

exec /usr/sbin/php-fpm81 -F