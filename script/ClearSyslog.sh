#!/bin/bash

# 清除日志脚本
LOG_DIR=/var/log

ROOT_UID=0     # $UID 为 0 的用户， 即 ROOT 用户

echo  $ROOT_UID
# 脚本需要root 用户权限运行，故对脚本用户进行判断，是否符合条件，并给出提示

if [ "$UID" -ne "$ROOT_UID" ]
   then
      echo "Must be root to run this script. "  #  给出提示
      exit 1 
fi

# 如果 切换 到指定的目录不成功， 则给出提示， 并终止程序运行
cd $LOG_DIR || {
    echo "Cannot change to necessary directory"
    exit 1
}

# 经过上面两个判断后， 可以对日志进行清空操作了 执行成功后 返回友好提示

cat /dev/null > system.log && {
    echo "Logs claned up. "
    exit 0      # 退出之前返回 0 表示成功，返回1表示失败
}

echo "Logs cleaned up fail."
exit 1

