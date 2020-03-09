#!/bin/bash

apt update
apt dist-upgrade -y
apt install -y mc git wget apache2 php php-mcrypt php-curl
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.0/apache2/php.ini
cd /usr/local/bin && wget -O up https://raw.githubusercontent.com/kiperos/w/master/uplist.sh && chmod +x up
echo "put list of domains in format: 
prokladka donor
prokladka2 donor2
prokladka3 donor3"
> /var/www/html/index.html
