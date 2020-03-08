#!/bin/bash

# ${GREEN} commands  {NC}
GREEN='\033[0;32m'      # ${GREEN}
RED='\033[0;31m'        # ${RED}
NC='\033[0m' # No Color # ${NC}

filepath=$(readlink -f $1)

echo "###### Put your domains lines and press 'Ctrl + O' then 'Enter' and 'Ctrl + X' OR 'F3' then 'Enter' and 'F2' !!! ######" > /root/domains

nano /root/domains

sed -i -e "1d" /root/domains


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

echo -e "${GREEN} $prokladka successfully clonned from $donor ${NC}"

done < /root/domains

echo ""
echo -e "${GREEN} Please save your domains !!! ${NC}"

echo ""
echo ""
echo ""
echo ""
echo "#####################################################"
cat $filepath
echo "#####################################################"
