#!/bin/bash
#
##脚本适用于CentOS 7系列##
#

#1.安装基础软件包
yum install -y epel-release
yum clean all
yum makecache
yum install -y wget rsync lrzsz openssh-clients telnet mlocate sysstat ntsysv iftop ntp bind-utils expect glances zip unzip man nrpe lsof tcpdump nmap traceroute elinks python-pip mysql strace curl net-snmp nagios-plugins nagios-nrpe salt-minion ntpdate libselinux-python gcc

#2.优化内核
mv /etc/sysctl.conf /etc/sysctl.conf-default_bak
cat > /etc/sysctl.conf<<EOF
kernel.core_uses_pid = 1
kernel.msgmax = 65536
kernel.msgmnb = 65536
kernel.shmall = 4294967296
kernel.shmmax = 68719476736
kernel.sysrq = 0
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
##listen()的默认参数,挂起请求的最大数量.默认是128.对繁忙的服务器,增加该值有助于网络性能.可调整到256.##
net.core.somaxconn = 32768
##发送套接字缓冲区大小的缺省值,8MB ##
net.core.wmem_default = 8388608
##发送套接字缓冲区（接收窗口）大小的最大值,最大的TCP数据发送缓冲,16MB ##
net.core.wmem_max = 16777216
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.ip_forward = 0
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 30
##系统中最多有多少个TCP套接字不被关联到任何一个用户文件句柄上。如果超过这个数字，孤儿连接将即刻被复位并打印出警告信息.
##这个限制仅仅是为了防止简单的DoS攻击，你绝对不能过分依靠它或者人为地减小这个值，更应该增加这个值(如果增加了内存之后)
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_tw_buckets = 200000
##net.ipv4.tcp_mem[0]:低于此值,TCP没有内存压力.
##net.ipv4.tcp_mem[1]:在此值下,进入内存压力阶段.
##net.ipv4.tcp_mem[2]:高于此值,TCP拒绝分配socket.
##上述内存单位是页,而不是字节.可参考的优化值是:786432 1048576 1572864
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_rmem = 4096 87380 4194304
net.ipv4.tcp_sack = 1
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
##网卡设备将请求放入队列的长度，每个网络接口接收数据包的速率比内核处理这些包的速率快时，允许送到队列的最大数目，一旦超过将被丢弃。##
net.core.netdev_max_backlog = 32768
##超过这个数量，系统将不再接受新的TCP连接请求，一定程度上可以防止系统资源耗尽。可根据情况增加该值以接受更多的连接请求。默认值1024## 
net.ipv4.tcp_max_syn_backlog = 65536
#当出现SYN等待队列溢出时，启用cookie来处理，可防范少量的SYN攻击。默认为0，表示关闭##
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_timestamps = 0
##默认0，tw快速回收
net.ipv4.tcp_tw_recycle = 1
##开启重用，允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭##
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_wmem = 4096 16384 4194304
net.ipv4.ip_local_reserved_ports = 20443,20080,8080,8087,3306,20443,20080,8080,8087,10000-13000 
##elasticsearch 需要此配置

vm.max_map_count = 655350
EOF
sysctl -p

#3.优化文件打开数
##centos 6版本，是先读/etc/security/limits.conf，如果/etc/security/limits.d/目录下还有配置文件的话##
##会遍历读取里面文件，所以/etc/security/limits.d/里面的文件里面的配置会覆盖/etc/security/limits.conf的配置##
sed -i "/nofile/s/^/#/g" /etc/security/limits.conf ##注释原有的nofile行
sed -i "/nproc/s/^/#/g" /etc/security/limits.conf ##注释原有的nproc行
echo "* soft nofile 1048576" >>/etc/security/limits.conf
echo "* hard nofile 1048576" >>/etc/security/limits.conf
echo "root soft nofile 1048576" >>/etc/security/limits.conf
echo "root hard nofile 1048576" >>/etc/security/limits.conf
echo "* soft nproc 65535" >>/etc/security/limits.conf
echo "* hard nproc 65535" >>/etc/security/limits.conf
echo "root soft nproc unlimited" >>/etc/security/limits.conf
echo "root hard nproc unlimited" >>/etc/security/limits.conf

sed -i "/nproc/s/^/#/g" /etc/security/limits.d/90-nproc.conf ##注释原有的nproc行
sed -i "/nofile/s/^/#/g" /etc/security/limits.d/90-nproc.conf ##注释原有的nofile行
echo "* soft nofile 1048576" >>/etc/security/limits.d/90-nproc.conf
echo "* hard nofile 1048576" >>/etc/security/limits.d/90-nproc.conf
echo "root soft nofile 1048576" >>/etc/security/limits.d/90-nproc.conf
echo "root hard nofile 1048576" >>/etc/security/limits.d/90-nproc.conf
echo "* soft nproc 65535" >>/etc/security/limits.d/90-nproc.conf
echo "* hard nproc 65535" >>/etc/security/limits.d/90-nproc.conf
echo "root soft nproc unlimited" >>/etc/security/limits.d/90-nproc.conf
echo "root hard nproc unlimited" >>/etc/security/limits.d/90-nproc.conf
echo "* soft memlock unlimited" >>/etc/security/limits.d/90-nproc.conf
echo "* hard memlock unlimited" >>/etc/security/limits.d/90-nproc.conf


#4.sudo权限设置
#echo "stock ALL=NOPASSWD:/bin/mount/,/bin/umount,/usr/bin/yum" >> /etc/sudoers

##Cmnd_Alias FILESOCKET = /usr/bin/sudo,/bin/su,/bin/kill,/bin/mount,/bin/umount,/bin/netstat
##golden ALL=(root) NOPASSWD: FILESOCKET

grep 'stock ALL=(ALL) NOPASSWD: ALL' /etc/sudoers || echo 'stock ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
grep 'Defaults:stock !requiretty' /etc/sudoers || echo 'Defaults:stock !requiretty' >>/etc/sudoers

#5.hostname设置
host_name=`hostname`
if [ "$host_name" = "localhost" ] || [ "$host_name" = "localhost.localdomain" ]
then
    ip_addr=`ip a | grep "scope global" | awk '{print $2}' | awk -F '/' '{print $1}' | sed 's/\./-/g'`
    hostname $ip_addr
    sed -i "/127.0.0.1/s/$/ $ip_addr/g" /etc/hosts
fi

#6.禁用IPv6
#cat > /etc/modprobe.d/ipv6.conf << EOFI
#
#
#
#---------------custom-----------------------
#
#alias net-pf-10 off
#options ipv6 disable=1
#EOFI
#sed -i "/^NETWORKING_IPV6.*/d" /etc/sysconfig/network
#echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network
#cat /etc/sysconfig/network | grep NETWORKING_IPV6

#7.关闭selinux策略#####
sed -i '7c SELINUX=disabled' /etc/selinux/config 
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/sysconfig/selinux
setenforce 0


#8.创建普通用户
useradd stock
echo "password"|passwd --stdin stock
mkdir -p /home/stock/.ssh/
chown stock:stock -R /home/stock
mkdir /stock
chown stock:stock -R /app

#END
exit 0

