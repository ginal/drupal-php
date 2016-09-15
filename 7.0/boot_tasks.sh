#!/bin/ash

set -eo pipefail

if [ -n "$PHP_SENDMAIL_PATH" ]; then
     sed -i 's@^;sendmail_path.*@'"sendmail_path = ${PHP_SENDMAIL_PATH}"'@' /etc/php5/php.ini
fi

if [ "$PHP_XDEBUG_ENABLED" -eq "1" ]; then
     sed -i 's/^;zend_extension.*/zend_extension = xdebug.so/' /etc/php5/conf.d/xdebug.ini
fi

# generate host keys if not present
ssh-keygen -A

# change root password
if [ ! "x$ROOT_PASSWORD" = "x" ]; then
      echo "root:$ROOT_PASSWORD" | chpasswd
fi

# add ssh key
if [ ! "x$ROOT_KEY" = "x" ]; then
      mkdir /root/.ssh
      chmod 700 /root/.ssh
      echo "$ROOT_KEY" > /root/.ssh/authorized_keys
      chmod 600 /root/.ssh/authorized_keys
fi
