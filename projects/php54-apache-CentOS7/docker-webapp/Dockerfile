FROM  centos:7
LABEL  maintainer "Kazuhiro Uchimura <uchimura@pencil.co.jp>"

RUN yum -y update && yum clean all
RUN mv /etc/localtime /etc/localtime.org && cp /usr/share/zoneinfo/Japan /etc/localtime

RUN yum -y install postfix cyrus-sasl cyrus-sasl-plain cyrus-sasl-md5; yum clean all
ADD etc/sasl2/smtpd.conf /etc/sasl2/smtpd.conf
ADD scripts/postfix.sh /root/postfix.sh
RUN /bin/sh /root/postfix.sh
CMD /bin/bash -c "systemctl start postfix"

RUN yum -y install httpd mod_ssl php php-cli php-common php-devel php-gd php-pdo php-pear php-process php-xml php-mbstring php-intl php-soap php-mysql gd libicu; yum clean all; systemctl enable httpd.service
#[TBV] php-mcrypt, php-json, php-mysqlnd
RUN mv /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.org && mkdir /etc/httpd/conf.d/vhosts.d && mkdir /var/www/vhosts
ADD etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf
ADD etc/httpd/conf.d/vhosts.conf /etc/httpd/conf.d/vhosts.conf
ADD etc/httpd/conf.d/vhosts.d/0.default.conf /etc/httpd/conf.d/vhosts.d/0.default.conf
VOLUME /var/www/vhosts/localhost.localdomain.tld
ADD scripts/httpd.sh /root/httpd.sh
RUN /bin/sh /root/httpd.sh
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
