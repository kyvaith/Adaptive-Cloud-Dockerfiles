FROM centos:7.1.1503
MAINTAINER OiSiS <oisis@o2.pl>

# Śmieci po Alpine Linux:
#
#ENV php_conf /etc/opt/remi/php70/php.ini
#ENV fpm_conf /etc/php7/php-fpm.d/www.conf
#ENV composer_hash e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae
#
# Alpine linux install - extra tools
# apk add --no-cache bash openssh-client wget nginx supervisor curl git
#
#php7 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
#php7 -r "if (hash_file('SHA384', 'composer-setup.php') === '${composer_hash}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
#php7 composer-setup.php --install-dir=/usr/bin --filename=composer && \
#php7 -r "unlink('composer-setup.php');"

################################
# Clean up first
RUN yum clean all

# Install epel repo - needed by REMI repo
RUN yum -y install epel-release.noarch

# Install additional repo - REMI(we need it for PHP7X)
RUN /usr/bin/rpm -ihv --replacepkgs http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# Install PHP7.0
RUN yum -y install php70-php-fpm php70-php-common php70-php-json php70-runtime php70-php-bcmath \
  php70-php-enchant php70-php-gd php70-php-pecl-geoip php70-php-gmp php70-php-pecl-igbinary \
  php70-php-pecl-imagick php70-php-imap php70-php-intl php70-php-xml php70-php-pecl-mailparse \
  php70-php-mbstring php70-php-mcrypt php70-php-pecl-memcache php70-php-pecl-memcached \
  php70-php-mysqlnd php70-php-mysqlnd php70-php-pdo php70-php-pspell php70-php-soap \
  php70-php-tidy php70-php-xmlrpc php70-php-opcache php70-php-pecl-zip

# Install and add Supervisor conf::
RUN yum -y install supervisor
ADD conf/supervisor/supervisord.conf /etc/supervisord.conf

# Install and config Nginx:
RUN yum -y install nginx
RUN rm -Rf /etc/nginx/nginx.conf
ADD conf/nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html  #--> from /var/www/app
RUN mkdir -p /var/run/nginx #--> from /run/nginx
RUN mkdir -p /etc/nginx/sites-available/
RUN mkdir -p /etc/nginx/sites-enabled/
RUN mkdir -p /etc/nginx/ssl/
ADD conf/nginx/nginx-site.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# copy in code
ADD src/ /var/www/html/

EXPOSE 443 80

#CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
CMD ["/start.sh"]
