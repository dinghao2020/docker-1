#!/usr/bin/env sh
set -e

#start db
mysqld_safe --user=mysql --datadir=/opt/mysql&

sleep 5

#if no index
if [ ! -e /var/www/html/index.php ];then
  echo '<?php' >/var/www/html/index.php
  echo 'phpinfo();' >>/var/www/html/index.php
  echo '?>' >>/var/www/html/index.php
fi

#start nginx
/usr/sbin/nginx

#init walle
/opt/walle-web/yii walle/setup --interactive=0

exec $@
