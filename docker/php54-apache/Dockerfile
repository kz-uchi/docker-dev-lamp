FROM php:5.4-apache
LABEL  maintainer "Kazuhiro Uchimura <uchimura@pencil.co.jp>"
ADD php.ini /usr/local/etc/php/conf.d/php.ini
RUN apt-get update && docker-php-ext-install pdo mbstring json mysqli
#RUN docker-php-ext-install xml
#stdout.
#  configure: error: xml2-config not found. Use --with-libxml-dir=<DIR>
#RUN docker-php-ext-install mcrypt 
#stdout.
#  configure: error: mcrypt.h not found. Please reinstall libmcrypt.
#RUN docker-php-ext-install intl
#stdout.
#  configure: error: Unable to detect ICU prefix or no failed. Please verify ICU install prefix and make sure icu-config works.
#RUN docker-php-ext-install soap
#stdout.
#  configure: error: xml2-config not found. Please check your libxml2 installation.
#RUN docker-php-ext-install gd
#stdout.
#  If configure fails try --with-jpeg-dir=<DIR>
#  If configure fails try --with-vpx-dir=<DIR>
#  configure: error: png.h not found.
CMD ["apache2ctl", "graceful"]
