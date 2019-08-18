#!/bin/bash
#Filename nginx_logs.sh wufenglun 20140522 First Release
#nginx日志切割脚本
#author: http://www.nginx.cn

#!/bin/bash
#设置日志文件存放目录
logs_path="/kingdee/nginxLog/"
#设置pid文件
pid_path="/kingdee/nginxLog/nginx.pid"

#重命名日志文件
mv ${logs_path}access.log ${logs_path}access_$(date -d "yesterday" +"%Y%m%d").log
mv ${logs_path}error.log ${logs_path}error_$(date -d "yesterday" +"%Y%m%d").log

#重命名控制台日志
mv ${logs_path}console_access.log ${logs_path}console_access.log_$(date -d "yesterday" +"%Y%m%d").log
mv ${logs_path}console_error.log ${logs_path}console_error.log_$(date -d "yesterday" +"%Y%m%d").log
#向nginx主进程发信号重新打开日志
kill -USR1 `cat ${pid_path}`
kill -USR1 `cat ${pid_path_console}`
chown -R root.root access.log
chown -R root.root error.log
#删除1天前的日志
find /kingdee/nginxLog -type f -mtime +4 -name "access_*.log" -print -exec rm -rf {} \;
find /kingdee/nginxLog -type f -mtime +4 -name "error_*.log" -print -exec rm -rf {} \;
