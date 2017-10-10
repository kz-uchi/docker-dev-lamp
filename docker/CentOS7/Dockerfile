FROM  centos:7
LABEL  maintainer "Kazuhiro Uchimura <uchimura@pencil.co.jp>"

# yum update
# 
RUN yum -y update\
  && yum clean all

# timezone
# 
RUN mv /etc/localtime /etc/localtime.org\
  && cp /usr/share/zoneinfo/Japan /etc/localtime

# MTA (Postfix)
# 
RUN yum -y install postfix cyrus-sasl cyrus-sasl-plain cyrus-sasl-md5
ADD etc/sasl2/smtpd.conf /etc/sasl2/smtpd.conf
ADD scripts/postfix.sh /root/postfix.sh
RUN /bin/sh /root/postfix.sh
CMD /bin/bash -c "systemctl start postfix"

# httpd (Apache, php)
RUN yum -y install httpd mod_ssl php php-cli php-common php-devel php-gd php-pdo php-pear php-process php-xml php-mbstring php-intl php-soap php-mysql gd libicu
#TBV. php-mcrypt, php-json, php-mysqlnd
RUN mv /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.org && mkdir /etc/httpd/conf.d/vhosts.d && mkdir /var/www/vhosts
ADD etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf
ADD etc/httpd/conf.d/vhosts.conf /etc/httpd/conf.d/vhosts.conf
ADD etc/httpd/conf.d/vhosts.d/0.default.conf /etc/httpd/conf.d/vhosts.d/0.default.conf
VOLUME /var/www/vhosts/localhost.localdomain.tld
ADD scripts/httpd.sh /root/httpd.sh
RUN /bin/sh /root/httpd.sh
CMD /bin/bash -c "systemctl start httpd"

# execute
# 
#CMD ["/sbin/init"]

#ADD nginx.conf /etc/nginx/nginx.conf
#ADD fastcgi.conf /etc/nginx/fastcgi.conf
#ADD server.conf /etc/nginx/conf.d/default.conf
#ADD localhost.key /etc/ssl/private/localhost.key
#ADD localhost.crt /etc/ssl/certs/localhost.crt

#FROM php:5.6.29-fpm
#
#ADD php.ini /usr/local/etc/php/conf.d/php.ini
#
#RUN apt-get update \
#  && docker-php-ext-install pdo_mysql mysqli mbstring
#
#RUN apt-get update \
#  && apt-get install -y libmemcached-dev zlib1g-dev \
#  && pecl install memcached-2.2.0 \
#  && docker-php-ext-enable memcached

#RUN  
#ADD  
#CMD  
#ENTRYPOINT  
#WORKDIR  
#ENV  
#USER  
#EXPOSE  
#VOLUME  