#!/bin/bash 

# exec 命令解析
# exec 命令 打开文件后，read命令每次都会将文件指针移动到 文件的下一行进行读取，直到下一行的。

exec < tmp.log  #读取log 内容

while read line  # 利用read 一行行读取处理
   do 
        echo $line
   done
   echo ok


