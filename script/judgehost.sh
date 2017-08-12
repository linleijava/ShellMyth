#!/bin/bash

# 判断 /etc/hosts  ip 里面 hostname

echo "please input ip address"

read ip
[ -n "`grep "$ip" /etc/hosts `" ] && echo "The hostname is : `grep  "$ip" /etc/hosts |awk '{print $2}'`" || echo "The  ip is invalid"

