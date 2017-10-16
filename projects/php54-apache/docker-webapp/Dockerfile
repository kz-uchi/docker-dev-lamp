FROM php:5.4-apache
LABEL  maintainer "Kazuhiro Uchimura <uchimura@pencil.co.jp>"
ADD php.ini /usr/local/etc/php/conf.d/php.ini
ADD localhost.localdomain.tld.crt /etc/ssl/certs/ssl-cert-snakeoil.pem
ADD localhost.localdomain.tld.key /etc/ssl/private/ssl-cert-snakeoil.key
RUN apt-get update\
    && docker-php-ext-install pdo mbstring json mysqli\
    && apt-get install -y\
        libfreetype6-dev\
        libjpeg62-turbo-dev\
        libmcrypt-dev\
        libpng-dev\
        libpng12-dev\
        openssl libssl-dev\
        libxml2-dev\
    && docker-php-ext-install iconv mcrypt xml soap\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/\
    && docker-php-ext-install gd
# TBC. php-intl, libicu
RUN sed -i -e 's/^ServerTokens OS/ServerTokens Prod/g' /etc/apache2/conf-available/security.conf\
    && cd /etc/apache2/conf-enabled\
    && ln -s ../conf-available/charset.conf\
    && ln -s ../conf-available/security.conf\
    && cd /etc/apache2/mods-enabled\
    && ln -s ../mods-available/rewrite.load\
    && ln -s ../mods-available/socache_shmcb.load\
    && ln -s ../mods-available/ssl.load\
    && ln -s ../mods-available/ssl.conf\
    && cd /etc/apache2/sites-enabled\
    && ln -s ../sites-available/000-default.conf\
    && ln -s ../sites-available/default-ssl.conf
