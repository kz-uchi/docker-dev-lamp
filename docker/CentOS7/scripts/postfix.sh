#!/bin/sh
cp /etc/postfix/main.cf{,.org}
sed -i -e "s/^#myhostname = virtual.domain.tld/myhostname = loaclhost.localdomein.tld/g" /etc/postfix/main.cf
sed -i -e "s/^#mydomain = domain.tld/mydomain = localdomein.tld/g" /etc/postfix/main.cf
sed -i -e 's/^#myorigin = $mydomain/myorigin = $mydomain/g' /etc/postfix/main.cf
sed -i -e 's/^#inet_interfaces = all/inet_interfaces = all/g' /etc/postfix/main.cf
sed -i -e 's/^inet_interfaces = localhost/#inet_interfaces = localhost/g' /etc/postfix/main.cf
sed -i -e 's/^#home_mailbox = Maildir\//home_mailbox = Maildir\//g' /etc/postfix/main.cf
echo 'smtpd_banner = $myhostname ESMTP unknown' >> /etc/postfix/main.cf
echo 'smtpd_sasl_auth_enable = yes' >> /etc/postfix/main.cf
echo 'smtpd_sasl_local_domain = $myhostname' >> /etc/postfix/main.cf
echo 'smtpd_recipient_restrictions = permit_mynetworks permit_sasl_authenticated reject_unauth_destination' >> /etc/postfix/main.cf
echo 'smtpd_sasl_security_options = noanonymous, noplaintext' >> /etc/postfix/main.cf
mv /etc/sasl2/smtpd.conf{,.org}
echo user |saslpasswd2 -p -c -u loalhost.localdomain.tld password
chgrp postfix /etc/sasldb2
chown 600 /etc/sasldb2
systemctl start saslauthd && systemctl enable saslauthd
mkdir -p /etc/skel/Maildir/{new,cur,tmp} && chmod -R 700 /etc/skel/Maildir/
#systemctl start postfix && systemctl enable postfix
