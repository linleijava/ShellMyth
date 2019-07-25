#

#停止firewalld服务
systemctl stop firewalld
#禁用firewalld服务
systemctl mask firewalld


#先检查是否安装了iptables
service iptables status
#安装iptables
yum install -y iptables
#升级iptables
yum update iptables 
#安装iptables-services
yum install iptables-services


1. iptables  配置文件

# vim /etc/sysconfig/iptables 增加防火墙设置

# 实例

-A INPUT -p tcp -m state --state NEW -m tcp  --dport 6379 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 6380 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 6381 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 16379 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 16380 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 16381 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 37017 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 37018 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 37019 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 27020 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 5672 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 15672 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 25672 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 9092 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 2189 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 2889 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp  --dport 3889 -j ACCEPT
# 指定地址ip 访问 端口

-A INPUT -s 10.10.199.186/32  -p tcp -m tcp  --dport 9200 -j ACCEPT
-A INPUT -s 10.10.199.187/32  -p tcp -m tcp  --dport 9200 -j ACCEPT
-A INPUT -s 10.10.199.188/32  -p tcp -m tcp  --dport 9200 -j ACCEPT
-A INPUT -s 10.10.199.189/32  -p tcp -m tcp  --dport 9200 -j ACCEPT
-A INPUT -s 10.10.199.194/32  -p tcp -m tcp  --dport 9200 -j ACCEPT
-A INPUT -s 10.10.199.195/32  -p tcp -m tcp  --dport 9200 -j ACCEPT
-A INPUT -s 10.10.199.186/32  -p tcp -m tcp  --dport 9300 -j ACCEPT
-A INPUT -s 10.10.199.187/32  -p tcp -m tcp  --dport 9300 -j ACCEPT
-A INPUT -s 10.10.199.188/32  -p tcp -m tcp  --dport 9300 -j ACCEPT
-A INPUT -s 10.10.199.189/32  -p tcp -m tcp  --dport 9300 -j ACCEPT
-A INPUT -s 10.10.199.194/32  -p tcp -m tcp  --dport 9300 -j ACCEPT
-A INPUT -s 10.10.199.195/32  -p tcp -m tcp  --dport 9300 -j ACCEPT
-A INPUT -s 10.10.199.186/32  -p tcp -m tcp  --dport 11211 -j ACCEPT
-A INPUT -s 10.10.199.187/32  -p tcp -m tcp  --dport 11211 -j ACCEPT
-A INPUT -s 10.10.199.188/32  -p tcp -m tcp  --dport 11211 -j ACCEPT
-A INPUT -s 10.10.199.189/32  -p tcp -m tcp  --dport 11211 -j ACCEPT
-A INPUT -s 10.10.199.192/32  -p tcp -m tcp  --dport 11211 -j ACCEPT
-A INPUT -s 10.10.199.186/32  -p tcp -m tcp  --dport 2181 -j ACCEPT
-A INPUT -s 10.10.199.187/32  -p tcp -m tcp  --dport 2181 -j ACCEPT
-A INPUT -s 10.10.199.188/32  -p tcp -m tcp  --dport 2181 -j ACCEPT
-A INPUT -s 10.10.199.189/32  -p tcp -m tcp  --dport 2181 -j ACCEPT
-A INPUT -s 10.10.199.194/32  -p tcp -m tcp  --dport 2181 -j ACCEPT
-A INPUT -s 10.10.199.195/32  -p tcp -m tcp  --dport 2181 -j ACCEPT
-A INPUT -s 10.10.199.186/32  -p tcp -m tcp  --dport 2888 -j ACCEPT
-A INPUT -s 10.10.199.187/32  -p tcp -m tcp  --dport 2888 -j ACCEPT
-A INPUT -s 10.10.199.188/32  -p tcp -m tcp  --dport 2888 -j ACCEPT
-A INPUT -s 10.10.199.189/32  -p tcp -m tcp  --dport 2888 -j ACCEPT
-A INPUT -s 10.10.199.194/32  -p tcp -m tcp  --dport 2888 -j ACCEPT
-A INPUT -s 10.10.199.195/32  -p tcp -m tcp  --dport 2888 -j ACCEPT
-A INPUT -s 10.10.199.187/32  -p tcp -m tcp  --dport 3888 -j ACCEPT
-A INPUT -s 10.10.199.188/32  -p tcp -m tcp  --dport 3888 -j ACCEPT
-A INPUT -s 10.10.199.189/32  -p tcp -m tcp  --dport 3888 -j ACCEPT
-A INPUT -s 10.10.199.194/32  -p tcp -m tcp  --dport 3888 -j ACCEPT
-A INPUT -s 10.10.199.195/32  -p tcp -m tcp  --dport 3888 -j ACCEPT


# -A INPUT -j REJECT --reject-with icmp-host-prohibited，这行已拒绝其他端口的命令，如果我们将新插入的开放端口在放在这行命令之后的情况下，后面的配置开放的端口是不会被启用的
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
