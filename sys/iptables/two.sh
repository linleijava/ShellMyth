

# 允许一个网段访问，其他的不允许


*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -s 10.10.199.0/24 -j ACCEPT
-A INPUT -p udp -s 10.10.199.0/24 -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -s 0.0.0.0/0 -j DROP
-A INPUT -p udp -s 0.0.0.0/0 -j DROP
COMMIT

