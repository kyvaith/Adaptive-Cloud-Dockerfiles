FROM centos:7.1.1503
MAINTAINER OiSiS <oisis@o2.pl>

# Clean up first
RUN yum clean all

# Remove fakesystemd and replace with full systemd
RUN rpm -e fakesystemd --nodeps

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

# Setup PHP
RUN rm -f /etc/opt/remi/php70/php-fpm.d/www.conf
RUN rm -f /etc/opt/remi/php70/php-fpm.conf
ADD conf/php70/php-fpm.conf /etc/opt/remi/php70/
ADD conf/php70/www.conf /etc/opt/remi/php70/php-fpm.d/

# Install and configure Supervisor:
RUN yum -y install supervisor
ADD conf/supervisor/supervisord.conf /etc/supervisord.conf

# Install and config Nginx:
RUN curl -s "http://download.opensuse.org/repositories/home:/kyvaith:/Adaptive-Cloud/CentOS_7/home:kyvaith:Adaptive-Cloud.repo" -o /etc/yum.repos.d/Adaptive-Cloud.repo
RUN yum -y install nginx-1.11.2
RUN rm -Rf /etc/nginx/nginx.conf
ADD conf/nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html && chmod 775 /var/www/html && chown -R nobody:nobody /var/www/html
RUN mkdir -p /var/run/nginx
RUN mkdir -p /etc/nginx/{sites-available,sites-enabled,extra.conf.d,certs}
COPY conf/nginx/extra.conf.d /etc/nginx/extra.conf.d
ADD conf/nginx/nginx-site.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# Clean up:
RUN yum clean all
RUN rm -rf /var/cache/*
RUN echo "" > /var/log/yum.log

# Expose ports
EXPOSE 443 80

# Volumes to mount:
VOLUME ["/var/www/html"]
VOLUME ["/etc/nginx/extra.conf.d/"]

# Command to run
CMD ["/start.sh"]
