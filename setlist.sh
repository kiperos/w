#!/bin/bash

apt update
apt dist-upgrade -y
apt install -y mc git wget apache2 php php-mcrypt php-curl
cd /usr/local/bin && wget -O up https://raw.githubusercontent.com/kiperos/w/master/up.sh && chmod +x up
echo "put list of domains in format: 
prokladka donor
prokladka2 donor2
prokladka3 donor3"
