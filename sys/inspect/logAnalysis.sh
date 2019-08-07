#!/bin/bash

cat access.log | awk -F " " '{print $7}'| sort |uniq -c|head -10

netstat -na|grep "TIME_WAIT"|awk -F " " '{print $5,$6}'|awk -F ":" '{print $1,$2}'|awk -F " " '{print $1,$2,$3}' |sort|uniq -c| sort -rnk 1 |head -50


# 文件占用空间

lsof -n | grep deleted | grep java| awk -F " " '{print $9}'| grep kingdee|awk -F"/" '{print $4}'|uniq -c|wc -l

lsof -n | grep deleted | grep java| awk -F " " '{print $7,$9}'| sort -rnk 1


# 文件行变逗号+
cat app.list | awk '{printf $1","}'
