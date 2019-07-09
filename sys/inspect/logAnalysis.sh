#!/bin/bash

cat access.log | awk -F " " '{print $7}'| sort |uniq -c|head -10

netstat -na|grep "TIME_WAIT"|awk -F " " '{print $5,$6}'|awk -F ":" '{print $1,$2}'|awk -F " " '{print $1,$2,$3}' |sort|uniq -c| sort -rnk 1 |head -50

