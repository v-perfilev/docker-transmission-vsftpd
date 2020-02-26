#!/bin/sh

# create user and to allowed list
useradd "$USERNAME" -d /home/"$USERNAME" -s /bin/false -m
echo "$USERNAME:$PASSWORD" | /usr/sbin/chpasswd
echo "/bin/false" >> /etc/shells

# vsftpd settings
echo "$USERNAME" >> /etc/vsftpd.allowed_users

# qBittorrent settings
echo "Downloads\SavePath=/home/$USERNAME/" >> /root/.config/qBittorrent/qBittorrent.conf
echo "Downloads\TempPath=/home/$USERNAME/tmp/" >> /root/.config/qBittorrent/qBittorrent.conf

# start vsftpd
service vsftpd start

# start qBittorrent
/usr/bin/qbittorrent-nox
