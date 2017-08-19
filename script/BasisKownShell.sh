!/bin/bash

# 记录shell方面的常量信息

# 如 系统默认的 Shell 
# 1
echo $SHELL

# 2

grep root /etc/passwd

# 添加别名等快捷操作 
# echo "alias ll='ls -lat' " >> /etc/profile || {
#  echo "当前用户没有操作权限"
#  exit 1
#}

echo "alias ll='ls -lat' " >>  ~/.bash_profile


# 验证bash 软件是否有漏洞，检测办法
env x='() {:;}; echo be careful' bash -c "echo this is a test"

# 规范标准

# Date: 21:00 2017-8-11
# Author: Created by lei.lin
# Blog:
# Description: This scripts function is .....
# Version: 1.1

# 设置环境变量
# 1、 export 变量名=value
export Name=lei.lin
# 2、变量名=value；export 变量名
Son=yupeng.lin; export Son
# 3、declare -x 变量名=value
declare -x wife=yangyang

# 全局变量 设置配置文件如下：
#  /etc/profile
# /etc/bashrc
# /etc/profile.d

## 设置登录提示
# 1、/etc/motd 里面添加 提示字符串
# 2、/etc/profile.d 下面增加如下脚本

## 取消环境变量
# unset 消除本地变量和环境变量

# 时间设置
time=`date "+ %Y-%m-%d %H:%M:%S"`
echo $time

# 连续输出连续的数子或者字母
echo {1..100}
echo {A..z}
#  查看命令及路径 dirname 及 basename 命令 功能用户
echo $0
dirname $0
basename $0
# $# 实践 
echo  $1 $2 $3 $4 $5 $6 $7 $8 $9
echo $#         # 打印脚本命令行参数的个数
count=$#
echo $count

echo \$$#

# exec 命令： 在不创建新的子进程的前提下，转去执行指定命令

# exec date

# Shell 变量子串的实践

Wife="Lovely Yangyang"

echo ${Wife}

echo "变量值的长度"

echo $Wife|wc -l
expr length "$Wife"
echo "$Wife"| awk '{print length($0)}'

# time for n in {1..100}; do char=`seq -s "Wife" 100`; echo ${#char}; done
# for n in {1..10}; do char=`seq -s "Wife" 100`; echo ${#char}; done
#
echo "-------------------"

echo  "shell变量"


Para=abcABC123ABCabc
echo $Para

echo ${Para:2}
echo ${Para:2:6}
#printf("---------345------")
echo ${Para##a*c}
echo ${Para%%a*c}
#批量替换文件名称
for f in `ls *IMG*`; do mv $f `echo ${f//IMG/LINYUPENG}`;done

echo $test  # 变量未设置，输出时为空
result=${test:-UNSET} # test 没有值， 则返回UNSET 

echo $result
TEST="LINYUPNEG"
result1=${TEST:-UNSET}
echo $result1
echo ${key:?not defined}
