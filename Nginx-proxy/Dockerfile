FROM centos:7.1.1503
MAINTAINER OiSiS <oisis@o2.pl>

# Clean up first
RUN yum clean all

# Install Kyvaith YUM repo
RUN curl -s "http://download.opensuse.org/repositories/home:/kyvaith:/Adaptive-Cloud/CentOS_7/home:kyvaith:Adaptive-Cloud.repo" -o /etc/yum.repos.d/Adaptive-Cloud.repo

RUN yum -y install nginx-1.11.2 ca-certificates wget tar

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

# Install Forego
ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
RUN chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.7.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
  && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN sed -i '/sendfile        on;/a     server_tokens off;' /etc/nginx/nginx.conf

COPY ./files/ /app/
WORKDIR /app/

# Clean up:
RUN rpm -e wget tar
RUN yum clean all
RUN rm -rf /var/cache/*
RUN echo "" > /var/log/yum.log

# We still needs cache dir for Nginx
RUN mkdir -p /var/cache/nginx/client_temp

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
