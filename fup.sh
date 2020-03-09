#!/bin/sh

DOMAIN=$1

DESC="Create Domain $DOMAIN"
file_location="/etc/apache2/sites-available/$DOMAIN.conf"
file_slocation="/etc/apache2/sites-enabled/$DOMAIN.conf"

echo "$DESC"

cat > $file_location <<EOF
<VirtualHost *:80>
        ServerName $DOMAIN
 ServerAlias www.$DOMAIN

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/$DOMAIN

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF

ln -sf $file_location $file_slocation
mkdir /var/www/html/$DOMAIN
/etc/init.d/apache2 restart
