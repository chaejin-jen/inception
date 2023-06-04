#!/bin/sh

chown -R mysql:mysql /var/lib/mysql;

service mysql start;

if ! [ -f "/var/lib/mysql/.mysql.setup.ok" ]; then 
    mysql -hlocalhost -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE";
    mysql -hlocalhost -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'";
    mysql -hlocalhost -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'";
    mysql -hlocalhost -e "FLUSH PRIVILEGES";
    mysql -hlocalhost -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'";
    # mysql -hlocalhost -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('$MYSQL_ROOT_PASSWORD')"    
    mysql -hlocalhost -e "FLUSH PRIVILEGES";

    mysql -hlocalhost $MYSQL_DATABASE -u$MYSQL_ROOT -p$MYSQL_ROOT_PASSWORD;
    mysqladmin -hlocalhost -u$MYSQL_ROOT -p$MYSQL_ROOT_PASSWORD shutdown;
    touch /var/lib/mysql/.mysql.setup.ok;
fi

exec mysqld;
