#!/bin/bash

while IFS=" " read prokladka donor; do

DESC="Create prokladka $prokladka"
file_location="/etc/apache2/sites-available/$prokladka.conf"
file_slocation="/etc/apache2/sites-enabled/$prokladka.conf"

echo "$DESC"

cat > $file_location <<EOF
<VirtualHost *:80>
        ServerName $prokladka
 ServerAlias www.$prokladka

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/$prokladka

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF

ln -sf $file_location $file_slocation
mkdir /var/www/html/$prokladka
/etc/init.d/apache2 restart

cd /var/www/html/$prokladka

wget -r -k -l 3 -p -E -nc $donor

cd $donor

mv -fi * ../
cd ..
mv index.html index.php

echo "$prokladka successfully clonned from $donor"

done < $1
echo ""
echo "please save your domains"

echo ""

cat $1
