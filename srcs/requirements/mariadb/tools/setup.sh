#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

if [ ! -e /var/lib/mysql/.mysql.setup.ok ]; then 
    echo "mysql setup"
    service mysql start
    
    # init directory
    mysql_install_db --user=mysql --skip-test-db --skip-log-bin --datadir=/var/lib/mysql > /dev/null
    
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
    FLUSH PRIVILEGES;";

    mysql -u$MYSQL_ROOT -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES";
    
    mysqladmin -u$MYSQL_ROOT -p$MYSQL_ROOT_PASSWORD shutdown
    touch /var/lib/mysql/.mysql.setup.ok
fi

exec "$@"