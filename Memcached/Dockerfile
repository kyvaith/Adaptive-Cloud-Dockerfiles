FROM centos:7.1.1503
MAINTAINER OiSiS <oisis@o2.pl>

ENV MEMCACHED_USER=nobody

# Add Kyvaith repo
RUN curl -s http://download.opensuse.org/repositories/home:/kyvaith:/Adaptive-Cloud/CentOS_7/home:kyvaith:Adaptive-Cloud.repo -o /etc/yum.repos.d/Adaptive-Cloud.repo

# Setup Memcached
RUN yum -y install epel-release.noarch

# Remove fakesystemd
RUN rpm -e fakesystemd --nodeps

# Install deps for memcached
RUN yum -y install libevent perl systemd-sysv which memcached-1.4.28

# Clean up:
RUN yum clean all
RUN rm -rf /var/cache/*
RUN echo "" > /var/log/yum.log

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 11211/tcp 11211/udp

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/bin/memcached"]
