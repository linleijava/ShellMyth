#/bin/sh
#auth sky
#2019-05-31
#zabbix
#check CONTAINER
#zabbix数据库mysql 数据保存位置
mysqldir=/kingdee/zabbinxmysql
zabbixserver="10.10.182.224"
mydocker=`grep "harbor.yunzhijia.com" /etc/hosts`
if [ -z "$mydocker" ];then
   echo "120.92.36.114  harbor.yunzhijia.com" >>/etc/hosts
fi

if [ ! -f "harbor.yunzhijia.com.tar.gz" ];then
    echo "mydockerhub.tar.gz not exist!"
    exit 3
else
    if [ ! -d "/etc/docker/cert.d" ];then
          mkdir -p "/etc/docker/cert.d"
    fi
   # tar -xzvf harbor.yunzhijia.com.tar.gz -C /etc/docker/cert.d/
fi

if [ -z "$mysqldir" -o  -z "$zabbixserver" ];then
   echo "mysqldir or zabbixserver must not null" 
   exit 3
fi

zabbixid=`docker ps -q -a  --filter name=zabbix-appliance`
if [ ! -z "$zabbixid" ];then
   echo " zabbix-appliance container exist"
   exit 3
fi

echo "check zabbix image"
myzabbixreg="harbor.yunzhijia.com/monitor/zabbix"
imageid=`docker images "$myzabbixreg:alpine-4.0" -q`
if [ -z "$imageid" ];then
   echo "zabbix image not exist,now load zabbix images"
   if [ -f "zabbix.4.0.tar" ];then
      docker load -i zabbix.4.0.tar && docker tag "1342182e3cd4"   $myzabbixreg:alpine-4.0 #imageid sha256
   else
      echo "zabbix.4.0.tar not exist"
	  echo " pull $myzabbixreg:alpine-4.0"
	  docker pull $myzabbixreg:alpine-4.0
   fi
else
   echo "$myzabbixreg:alpine-4.0 image exist"
fi
#echo "run zabbix"
echo "prepare mysql dir"
if [ ! -d $mysqldir ];then
   mkdir -p $mysqldir
fi
docker run --name zabbix-appliance \
-p 8080:80 -p 10051:10051 -d \
-v $mysqldir:/var/lib/mysql/ \
-v /etc/localtime:/etc/localtime \
 $myzabbixreg:alpine-4.0 && echo -e "\n zabbix访问地址：http://$zabbixserver:8080 \n用户：Admin\n密码:zabbix" || { echo "some thing wrong exit!";exit 3; }


#grafana
#check CONTAINER
grafanaid=`docker ps -q -a  --filter name=grafana`
if [ ! -z "$grafanaid" ];then
   echo " grafana container exist"
   exit 3
fi

echo "check grafana image"
myrep=" harbor.yunzhijia.com/monitor/grafana"
imageid=`docker images "$myrep:zabbix" -q`
if [ -z "$imageid" ];then
   echo "grafana image not exist,now load grafana images"
   if [ -f "grafanazabbix.tar" ];then
      docker load -i grafanazabbix.tar && docker tag "42d2ba41f0cc"   $myrep:zabbix #imageid sha256
   else
      echo "grafanazabbix.tar  not exist"
          echo "docker pull  $myrep:zabbix "
          docker pull  $myrep:zabbix 
         
   fi
else
   echo "grafana:zabbix image exist"
fi
#echo "run grafana"
echo "prepare grafana datadir"
if [ ! -d $grafanadir ];then
   mkdir -p $grafanadir
fi

docker run  -d -p 3000:3000 --name=grafana \
    -v /etc/localtime:/etc/localtime \
    --add-host zabbixserver:$zabbixserver \
     $myrep:zabbix && echo -e "\n grafa访问地址：http://ip:3000 \n用户：admin\n密码:kingdee" || { echo "install grafa some thing wrong exit!";exit 3; }
