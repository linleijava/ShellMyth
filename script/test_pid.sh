#!/bin/bash
# $$实践 功能，获取进程号

# echo $$ > ../../a.pid

# sleep 300

# 范例 --- 现实中多次执行某一个脚本后的进程只能有一个

pidpath=../../pid.pid  # 定义pid 文件

if [ -f "$pidpath" ]  # 如果pid文件存在，则执行 then 后面的命令
   then
      kill `cat $pidpath` > /dev/null 2>&1  # 杀毒前一个进程号对应的进程
      rm -f $pidpath      # 删除pid文件
fi 
echo $$ > $pidpath    # 将当前 Shell 进程号记录到pid文件里

sleep 30 

