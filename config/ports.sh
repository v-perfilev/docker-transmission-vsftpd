#!/bin/sh

iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F

# disable all except of ssh and OpenVPN
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p udp --dport 1194 -j ACCEPT

# enable ftp (21 and 21100-21110) in docker for VPN users only
iptables -A FORWARD -p tcp ! -i tun0 --dport 21 -j DROP
iptables -A FORWARD -p tcp ! -i tun0 --match multiport --dports 21100:21110 -j DROP
# enable web (8080) in docker for VPN users only
iptables -A FORWARD -p tcp ! -i tun0 --dport 8080 -j DROP