#!/bin/sh

# create user and to allowed list
useradd "$USERNAME" -d /home/"$USERNAME" -s /bin/false -m
echo "$USERNAME:$PASSWORD" | /usr/sbin/chpasswd
echo "/bin/false" >> /etc/shells
echo "$USERNAME" >> /etc/vsftpd.allowed_users

#service vsftpd start
