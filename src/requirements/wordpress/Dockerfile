FROM alpine:3.17

# ARG MARIADB_DATA_DIR MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD

WORKDIR /var/www

RUN apk update && apk upgrade; \
    apk add --no-cache php php-fpm php-mysqli php-json php-curl php-dom php-exif php-fileinfo php-mbstring php-openssl php-xml php-zip wget unzip; \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php81/php-fpm.d/www.conf; \
    wget https://wordpress.org/latest.zip && \
    unzip latest.zip && cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip && rm -rf wp-config-sample.php \
    && chmod -R 777 wp-content

# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh


# ENTRYPOINT ["docker-entrypoint.sh"]

COPY ./wp-config.sh .
COPY ./docker-entrypoint.sh /e

RUN chmod +x wp-config.sh && ./wp-config.sh && rm ./wp-config.sh

EXPOSE 9000

CMD ["/usr/sbin/php-fpm81", "-F"]