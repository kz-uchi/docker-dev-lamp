#!/bin/sh
cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
sed -i -e 's/^AddDefaultCharset/#AddDefaultCharset/g' /etc/httpd/conf/httpd.conf
mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.org
/dev/null > /etc/httpd/conf.d/welcome.conf
sed -i -e "s/myhost.mydomain.tld/localhost.localdomain.tld/g" /etc/httpd/conf.d/vhosts.d/0.default.conf
sed -i -e "s/mydomain.tld/localdomain.tld/g" /etc/httpd/conf.d/vhosts.d/0.default.conf
cp /etc/httpd/conf.modules.d/00-base.conf /etc/httpd/conf.modules.d/00-base.conf.org
sed -i -e 's/#LoadModule usertrack_module modules\/mod_usertrack.so/LoadModule usertrack_module modules\/mod_usertrack.so/g' /etc/httpd/conf.modules.d/00-base.conf
cp -p /etc/php.ini /etc/php.ini.org
sed -i -e 's/^\;date\.timezone \=/date.timezone = "Asia\/Tokyo"/g' /etc/php.ini
sed -i -e 's/expose_php = On/expose_php = Off/g' /etc/php.ini
sed -i -e 's/^post_max_size = 8M/post_max_size = 128M/g' /etc/php.ini
sed -i -e 's/^upload_max_filesize = 2M/upload_max_filesize = 128M/g' /etc/php.ini
sed -i -e 's/\/var\/log\/httpd\/\*log/\/var\/log\/httpd\/*log \/var\/log\/httpd\/*\/*log/g' /etc/logrotate.d/httpd
#systemctl start httpd && systemctl enable httpd
