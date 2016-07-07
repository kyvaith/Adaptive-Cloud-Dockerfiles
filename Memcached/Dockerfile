FROM centos:7
MAINTAINER OiSiS <oisis@o2.pl>

# Copy our Memcached rpm into the cointainer
#COPY memcached-1.4.28-1.el7.centos.x86_64.rpm /tmp/memcached-1.4.28-1.el7.centos.x86_64.rpm

ENV MEMCACHED_USER=nobody

# Add Kyvaith repo
RUN curl -s http://download.opensuse.org/repositories/home:/kyvaith:/Adaptive-Cloud/CentOS_7/home:kyvaith:Adaptive-Cloud.repo -o /etc/yum.repos.d/Adaptive-Cloud.repo

# Setup Memcached
RUN rpm -Uvh http://mirror.metrocast.net/fedora/epel/7/x86_64/e/epel-release-7-7.noarch.rpm
RUN yum update -y

# Install deps for memcached
RUN yum -y install libevent perl systemd-sysv which memcached-1.4.28

# Install memcached
#RUN rpm -ihv /tmp/memcached-1.4.28-1.el7.centos.x86_64.rpm

# Clean up:
#RUN rm -f /tmp/memcached-1.4.28-1.el7.centos.x86_64.rpm
RUN yum clean all

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 11211/tcp 11211/udp

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/bin/memcached"]
