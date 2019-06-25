#!/bin/bash

#auth sky

#20190420

#mongodb 3.4以上版本，适用复制集备份（启用了用户认证），不适用分片，Mongodb的用户有全局备份权限（我以有Root权限为例）

mydump() {

#muser must be a root role or backup role

mongoport="$port" 

#dumpdir=/kingdee/mongodumpdata/$instance

#mypwd=/kingdee/kdinit/mongodump

dumpdir=/service/backup/$instance

mypwd=/service/backup

bin=/service/mongo/todo/bin/mongo  #mongo二进制文件位置

dumpbin=/service/mongo/todo/bin/mongodump #mongodump 二进制文件位置

out="$mypwd/output.log"

#################

#取星期几作为目录

mynum=`date +%u`

if [ -z "$mynum" ];then

   echo " Get a error"

   exit

fi

 

 

if [ ! -d $dumpdir/$mynum ];then

   mkdir -p $dumpdir/$mynum

else:

   rm -rf $dumpdir/$mynum  #清除7天前的数据

   mkdir -p $dumpdir/$mynum

fi

#echo $mynum

##################

gethosts=`echo -e "db.isMaster()[\"hosts\"].forEach(function(x){print(x)})\n"|$bin --host $host --port ${mongoport}   -u $muser -p $mpasswd --authenticationDatabase=admin --quiet`

getprimaryhost=`echo  -e "db.isMaster()[\"primary\"]\n"|$bin --host $host --port ${mongoport}   -u $muser -p $mpasswd --authenticationDatabase=admin --quiet`

for i in `echo $gethosts`:

do

   if [ "$i" != "$getprimaryhost" ];then

       slavehostinfo=$i

   break

   fi

done

slavehost=`echo $slavehostinfo|awk -F ':' '{print $1}'`

slaveport=`echo $slavehostinfo|awk -F ':' '{print $2}'`

dbs=`echo -e "rs.slaveOk();\nshow dbs"|$bin --host $slavehost --port ${slaveport} --quiet -u $muser -p $mpasswd  --authenticationDatabase=admin|grep -v empty|grep -v local`

 

#echo "$dbs"

 

dbs=`echo "$dbs"|awk {'{print $1}'}`

#echo "$dbs"

echo "databases: "$dbs

   if [ ! -d "$dumpdir" ];then

            mkdir -p $dumpdir

    fi

    echo "..dump " >> $out

    date >> $out

 for j in `echo $dbs`

     do

        echo "dump $j"

        dumpcmd="$dumpbin --host $slavehost --port ${slaveport} -u $muser -p $mpasswd  --authenticationDatabase=admin -d $j -o $dumpdir/${mynum}/"

      $dumpcmd

     done

 

echo " Dump..." >>$out

  date >> $out

   echo "  "

 

 

}

muser="mongouser" #mongodb用户

mpasswd="123456"  #用户密码请修改

for i in `cat mongoinfo`

do

   #echo $i

   host=`echo "$i"|awk -F ',' '{print $1}'`

   port=`echo "$i"|awk -F ',' '{print $2}'`

   instance=`echo "$i"|awk -F ',' '{print $3}'`

   echo $host,$port,$instance

   mydump

done
