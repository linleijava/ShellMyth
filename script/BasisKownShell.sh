#!/bin/bash

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
