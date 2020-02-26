#!/bin/sh

# create user and to allowed list
useradd "$USERNAME" -d /home/"$USERNAME" -s /bin/false -m
echo "$USERNAME:$PASSWORD" | /usr/sbin/chpasswd
echo "/bin/false" >> /etc/shells

# vsftpd settings
echo "$USERNAME" >> /etc/vsftpd.allowed_users

## transmission settings
sed -i 's%  "incomplete-dir": "",%  "incomplete-dir": "/home/'"$USERNAME"'/tmp/",%g' /root/.config/transmission-daemon/settings.json
sed -i 's%  "download-dir": "",%  "download-dir": "/home/'"$USERNAME"'/",%g' /root/.config/transmission-daemon/settings.json
sed -i 's%  "rpc-username": "",%  "rpc-username": "'"$USERNAME"'",%g' /root/.config/transmission-daemon/settings.json
sed -i 's%  "rpc-password": "",%  "rpc-password": "'"$PASSWORD"'",%g' /root/.config/transmission-daemon/settings.json

# start vsftpd
service vsftpd start

# start transmission
service transmission-daemon start

# workaround for not stopping
sleep 3650d
