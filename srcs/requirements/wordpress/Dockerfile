FROM alpine:3.17

RUN set -eux; \
    apk add --no-cache php php-common php-phar php-fpm php-mysqli php-json php-curl php-dom php-exif php-fileinfo php-mbstring php-openssl php-xml php-zip mariadb-client; \
    adduser -u 82 -D -S -G www-data www-data

COPY ./tools/script.sh /usr/local/bin/
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

RUN set -eux; \
    wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar /usr/local/bin/script.sh; \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/wordpress

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/script.sh"]

CMD ["/usr/sbin/php-fpm81", "-F"]