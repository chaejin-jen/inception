FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server

COPY ./tools/setup.sh /usr/local/bin/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# backwards compat
RUN chmod +x /usr/local/bin/setup.sh; \
    ln -s usr/local/bin/setup.sh

ENTRYPOINT ["setup.sh"]

EXPOSE 3306

CMD ["mysqld", "--user=mysql"]