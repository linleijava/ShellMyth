#!/bin/bash 


# 增加Nginx配置 进行下载索引

server {
        listen       9000;        #端口
        server_name  localhost;   #服务名
        charset utf-8; # 避免中文乱码
        root   /download;  #显示的根索引目录，注意这里要改成你自己的，目录要存在

        location / {
            autoindex on;             #开启索引功能
            autoindex_exact_size off; # 关闭计算文件确切大小（单位bytes），只显示大概大小（单位kb、mb、gb）
            autoindex_localtime on;   # 显示本机时间而非 GMT 时间
        }
    }
