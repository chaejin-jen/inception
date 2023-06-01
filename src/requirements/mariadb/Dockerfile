FROM alpine:3.17.0

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["entrypoint.sh"]
