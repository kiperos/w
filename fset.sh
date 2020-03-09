#!/bin/bash

apt update
apt dist-upgrade -y
apt install -y mc git wget apache2 php php-mcrypt php-curl
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.0/apache2/php.ini
