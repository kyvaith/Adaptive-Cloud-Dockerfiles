ENV VARS:
WEBROOT - nadpisuje domyślny web root (/var/www/html)
ERRORS - wyświetlanie błędów PHP
TEMPLATE_NGINX_HTML - nadpisywanie zminnych nginx - nie polecane

Build:
docker build -t kyvaith/nginx-php-fpm .
Run:
docker run --name nginx-php -it -d -p 8001:80 -p 443:8443 -v /home/docker/hosting1/html:/var/www/html -v /home/docker/hosting1/extra.conf.d:/etc/nginx/extra.conf.d/ kyvaith/nginx-php-fpm

Export/Import docker containers:
1. Export to tar file:
docker export memcached > /vagrant/tmp/memcached_last.tar
2. Import from tar file:
cat ./memcached_last.tar | docker import - memcached:new
3. Save image to file:
docker save -o /vagrant/tmp/nginx-php-fpm_last.tar 9ca0acd0816f
