ENV VARS:
WEBROOT - nadpisuje domyślny web root (/var/www/html)
ERRORS - wyświetlanie błędów PHP
TEMPLATE_NGINX_HTML - nadpisywanie zminnych nginx - nie polecane

Build:
docker build -t kyvaith/nginx-php .
Run:
docker run --name nginx-php -it --rm -p 80:9080 -p 443:8443 kyvaith/nginx-php-fpm
