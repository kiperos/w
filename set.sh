#!/bin/bash

archivepassword=$(cat /root/pass)

spinner ()
{
    bar=" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;34m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}



# Show "Done."
function say_done() {
    echo " "
    echo -e "Done."
    yes "" | say_continue
}


# Ask to Continue
function say_continue() {
    echo -n " To EXIT Press x Key, Press ENTER to Continue"
    read acc
    if [ "$acc" == "x" ]; then
        exit
    fi
    echo " "
}

# Show "Done."
function say_done_2() {
    echo " "
    echo -e "Done."
    say_continue_2
}

# Ask to Continue`
function say_continue_2() {
    echo -n " To EXIT Press x Key, Press ENTER to Continue"
    read acc
    if [ "$acc" == "x" ]; then
        exit
    fi
    echo " "
}

apt update
apt dist-upgrade -y
apt install -y mc git wget apache2 php php-mcrypt php-curl p7zip-full tmux
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.0/apache2/php.ini
wget https://github.com/kiperos/w/raw/master/main.7z

extract_main(){
clear
f_banner

ARCHIVEPASS=/root/pass

if [ -f $ARCHIVEPASS ]; then
  
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Extract archive"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
  
  
  
  #cd ak
  7z x main.7z -p$archivepassword; echo "Extract archive OK"
  mv /root/main/up.sh /usr/local/bin/up
  chmod +x /usr/local/bin/up
  
  rm -f main.7z; echo "remove archive OK"
  echo " OK"
  
 else 
  
  echo ""
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Extract navyson archive. File with archive password doesn't exist. Please Enter Your Password!"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
  echo -n " Please Enter Your Password: "; read -s archivepassword2
  7z x main.7z -p$archivepassword; echo "Extract archive OK"
  mv /root/main/up.sh /usr/local/bin/up
  sed -i -e 's/\r$//' /usr/local/bin/up
  chmod +x /usr/local/bin/up
  
  rm -f main.7z; echo "remove archive OK"
  echo " OK"
  fi

say_done


say_done_2
}


extract_main
tmux new-session -d -s 1
tmux attach
