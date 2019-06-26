#!/bin/bash

# author linlei

# doc: CentOS ssh 免密登录

su stock                  #切换到stock用户
cd ~                    #切换到stock家目录下
ll -a                   #检查是否存在.ssh目录，没有就mkdir .ssh
cd .ssh                 #没有目录就创建！
ssh-keygen -t rsa       #执行命令
# 更改.ssh目录、authorized_keys密钥权限（yzj账号下）
cat /home/stock/.ssh/id_rsa.pub >> /home/yzj/.ssh/authorized_keys
chmod 600 /home/stock/.ssh/authorized_keys
chmod 700 /home/stock/.ssh

# 将主操作服务器公钥远程传输到各服务器stock账号家目录/home/stock/.ssh/中

su - stock
scp authorized_keys stock@主机IP:/home/stock/.ssh/   #将主操作密钥传个各个服务器，实现免密登录操作。

