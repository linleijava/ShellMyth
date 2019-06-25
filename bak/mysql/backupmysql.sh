#!/bin/bash

# author linl

#20190420

backupdir=/backup/mysql

mysqlbin="/usr/bin/mysqldump"

mysqluser="admin"

mysqlpwd="password"

#取星期几作为目录

mynum=`date +%u`

if [ -z "$mynum" ];then

   echo " Get a error"

   exit

fi



if [ ! -d $backupdir/$mynum ];then

   mkdir -p $backupdir/$mynum

else:

   rm -rf $backupdir/$mynum  #清除7天前的数据

   mkdir -p $backupdir/$mynum

fi

echo "start backup mysql"

for i in `cat mysqlinfo`

do

   host=`echo "$i"|awk -F ',' '{print $1}'`

   port=`echo "$i"|awk -F ',' '{print $2}'`

   databasename=`echo "$i"|awk -F ',' '{print $3}'`

   $mysqlbin -h $host -P $port -u $mysqluser -p$mysqlpwd  $databasename   -e --max_allowed_packet=134217728  --net_buffer_length=8192 > ${backupdir}/$mynum/$databasename.sql

done

echo "mysqldum done!"
