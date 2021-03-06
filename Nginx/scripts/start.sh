#!/bin/bash

# Set custom webroot
if [ ! -z "$WEBROOT" ]; then
 sed -i "s#root /var/www/html;#root ${WEBROOT};#g" /etc/nginx/sites-available/default.conf
fi

# Display PHP error's or not
if [[ "$ERRORS" != "1" ]] ; then
 echo php_flag[display_errors] = off >> /etc/opt/remi/php70/php-fpm.conf
else
 echo php_flag[display_errors] = on >> /etc/opt/remi/php70/php-fpm.conf
fi

# Very dirty hack to replace variables in code with ENVIRONMENT values
if [[ "$TEMPLATE_NGINX_HTML" == "1" ]] ; then
  for i in $(env)
  do
    variable=$(echo "$i" | cut -d'=' -f1)
    value=$(echo "$i" | cut -d'=' -f2)
    if [[ "$variable" != '%s' ]] ; then
      replace='\$\$_'${variable}'_\$\$'
      find /var/www/html -type f -exec sed -i -e 's/'${replace}'/'${value}'/g' {} \;
    fi
  done
fi

# Lets run temporary php from stat.sh script
/opt/remi/php70/root/usr/sbin/php-fpm -c /etc/opt/remi/php70

# We have to create this directory for Nginx
mkdir -p /var/cache/nginx/client_temp
chown -R nobody:nobody /var/cache/nginx

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
