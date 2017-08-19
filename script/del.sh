#!/bin/bash


# 删除7天前的过期数据备份

# 如果忘记了定义path 变量， 不希望path 值为空值，就定义 /var/log 替代 path  空值

find ${path-/var/log} -name "*bz2" -type f -mtime +7|xargs sudo rm -f

echo $?


