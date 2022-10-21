#!/bin/bash

#We assume that user is root

if [ $whoami != root ]; then
    echo "Please set user to root"
    exit
fi

#Installation package
apt install proftpd-*
apt-get update ; apt-get upgrade
echo "Installation done"

#Starting server
service proftpd start
echo "Starting the server"

#Echo server's IP Adress
hostname -I | cut -f1 -d' '
echo "This is the server's IP"

#Enabling Anonymous and FTPS
mkdir -p /etc/proftpd/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out /etc/proftpd/ssl/proftpd-rsa.pem -keyout /etc/proftpd/ssl/proftpd-key.pem \
-subj "/C=''/ST=''/L=''/O=''/OU=''/CN=''" 
chmod 440 /etc/proftpd/ssl/proftpd-key.pem
cat configTLS.txt >> /etc/proftpd/proftpd.conf

#Starting operating server
sudo service proftpd restart
echo "User Anonymous is now enabled"
echo "Your FTP is now encrypted (FTPS)"
