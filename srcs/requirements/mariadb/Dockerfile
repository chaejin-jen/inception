FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install -y mariadb-server mariadb-client

COPY ./tools/setup.sh /usr/local/bin/setup.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

ENTRYPOINT ["sh", "/usr/local/bin/setup.sh"]

EXPOSE 3306
