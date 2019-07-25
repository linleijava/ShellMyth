# 防火墙

*  Tcp wrappers

* 基础

表主要有这四张：

filter表
NAT表
mangle表
raw表
每个表中可以用的 chains 不全相同，当然 iptables 支持新建 chains，而 chains 是 Netfilter 框架中制定的对数据包的 Hook Point，Hook Point 是一个数据包通过网卡流经系统内核相应的位置时会对数据包的流向做出一定的修改，在系统上存在5个 Hook Point 的挂载点

PREROUTING
INPUT
OUTPUT
FORWARD
POSTROUTING
target 中大部分是通用的，当然有部分是特定使用的，这里只列举常用的几种规则，更多的规则大家可以使用 man 来查看

ACCEPT：一旦包满足了指定的匹配条件，就会通过，并且不会再去匹配当前链中的其他规则或同一个表内的其他规则，但它还要通过其他表中的链
DROP：一旦包满足了指定的匹配条件，将会把该包丢弃，也就是说包的生命到此结束，不会再向前走一步，效果就是包被阻塞了。不会返回任何的消息
REJECT和DROP基本一样，一旦包满足了指定的匹配条件，将会把该包丢弃，但是它除了阻塞包之外，还向发送者返回错误信息。
SNAT：一旦包满足了指定的匹配条件，源网络地址转换
DNAT：一旦包满足了指定的匹配条件，目的网络地址转换
MASQUERADE和SNAT的作用相同，区别在于它不需要指定–to-source
REDIRECT：一旦包满足了指定的匹配条件，转发数据包一另一个端口
RETURN：一旦包满足了指定的匹配条件，使数据包返回上一层
MIRROR：颠倒IP头部中的源目地址，然后再转发包




* 规则

看到分布在每条链中的已经写入的规则，若我们还想到跟详细的结果可以使用这样的一个命令

sudo iptables -nvL --line

第一列 num 显示了该规则在该链中的顺序位置
第二列 pkts 显示了该规则处理的数据包数
第三列 bytes 显示了该规则处理的字节数，
第四列 target 显示了该规则所做的行为，
第五列 port 匹配的端口
第六列 opt 是 TCP 协议头部中 options 的一部分，并不是重点，我们可以不必关注，有兴趣的也可以通过维基百科深入了解
第七列、第八列 in、out 分别表示对从网卡进入与出去的限制 ip 的匹配条件
第九列、第十列 source、destination 表示对包中分析得出的数据源地址与数据的目的地址的匹配

保存

iptables-save

sudo iptables -t filter -I INPUT -p tcp --dport 80 -j DROP

#仅仅只是查看 INPUT 链是否加入了这条规则
sudo iptables -nvL INPUT

#然后我们再来尝试一次，能否查看到该网页
curl localhost


#删除我们之前添加的规则，这里没有添加 -t 的参数
#是因为不指明该参数，系统默认为修改 filter 表
sudo iptables -D INPUT -p tcp --dport 80 -j DROP

#添加拒绝的规则
sudo iptables -I INPUT -p tcp --dport 80 -j REJECT


#使用 limt 对 syn的每秒钟最多允许3个新链接
sudo iptables -A INPUT -p tcp --syn -m limit --limit 1/s  --limit-burst 3 -j ACCEPT

#或者针对每个客户端作出限制，每个客户端限制并发数为10个，这里的十个只是为了模拟，可以自己酌情考虑
sudo iptables -I INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 10 -j REJECT


看看我们的连接数量：

netstat -an | grep SYN

netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

