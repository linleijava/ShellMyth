#!/bin/bash

# 
# 文件占用空间

lsof -n | grep deleted | grep java| awk -F " " '{print $9}'| grep kingdee|awk -F"/" '{print $4}'|uniq -c|wc -l

lsof -n | grep deleted | grep java| awk -F " " '{print $7,$9}'| sort -rnk 1

lsof -n | grep deleted | grep java| awk -F " " '{print $9}'| grep kingdee|awk -F"/" '{print $4}'|uniq -c > servicename.txt

# /kingdee/jetty/etc/global.properties    /kingdee/openjetty/etc/global.properties

# appsys appservice
 
# appservice,jetty,war,13115,10.88.86.11,10.88.86.12,10.88.86.21,10.88.86.22,
# appsys,openjetty,war,13114,10.88.86.11,10.88.86.12,10.88.86.22,10.88.86.21,


/kingdee/jetty/domains/xxx/bin/jetty.sh
/kingdee/openjetty/domains/xxx/bin/openjetty.sh
/kingdee/bin/xxx/bin/


for name in `cat servicename.txt`
do

	if [ $? -eq 0 ]
	then
		echo " $name restart ok "
	else
		echo " $name  error "
	fi
	sleep 1

done

