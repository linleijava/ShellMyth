#!/bin/bash

#author linl

#20190625

#备份目录,可自行修改

backupdir="/backup/redis"

redisbin="/usr/bin/redis-cli"

#取当前备份时间（week）

savedate=`date +%u`

if [ -z "$savedate" ];then

   echo " Get a error"

   exit

fi

#savedate=` date +%Y%m%d`

#redis密码

pwd="yzjredis" 

 

if [ ! -d $backupdir/$savedate ];then

   mkdir -p $backupdir/$savedate

else:

   rm -rf $backupdir/$savedate

   mkdir -p $backupdir/$savedate

fi

for i in `cat redisinfo`

do

  echo $i

  host=`echo $i|awk -F ',' '{print $1}'`

  port=`echo $i|awk -F ',' '{print $2}'`

  instance=`echo $i|awk -F ',' '{print $3}'`

  ss=`redis-cli -h $host -p $port  SENTINEL get-master-addr-by-name $instance | awk "{print $1}"`

  echo "master is  "$ss

  masterip=`echo $ss|awk '{print $1}'`

  masterport=`echo $ss|awk '{print $2}'`

  # $redisbin -h $masterip -p $masterport -r 5 -i 1 -a $pwd info stats|grep instantaneous_ops_per_sec

  #info replication

  #$redisbin -h $masterip -p $masterport  -a $pwd info replication

  

  #info Memory

  # $redisbin -h $masterip -p $masterport  -a $pwd info memory|grep used_memory_human

  #getslavehost+port

  slaveinfo=`$redisbin -h $masterip -p $masterport  -a $pwd info replication|grep slave0:ip`

  slaveport=`echo $slaveinfo|awk -F ',' '{print $2}'|awk -F '=' '{print $2}'`

  slavehost=`echo $slaveinfo|awk -F ',' '{print $1}'|awk -F '=' '{print $2}'`

  #rdb save

  echo "$redisbin -h $slavehost -p $slaveport  -a $pwd  --rdb $backupdir/$savedate/$instance.rdb"

  $redisbin -h $slavehost -p $slaveport  -a $pwd  --rdb $backupdir/$savedate/$instance.rdb

done
