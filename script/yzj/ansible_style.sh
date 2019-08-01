

ansible-playbook update_nginx_upstream.yml -e {"app_name":"space","assignation_ip":"10.10.199.124,10.10.199.126,10.10.199.186,10.10.199.188","hosts":"10.10.199.184,10.10.199.185,10.10.199.194,10.10.199.195","ansible_become_method":"sudo","projectType":"jetty","ansible_become_user":"root","ansible_ssh_user":"yzj","http_port":"11754","ansible_become_pass":"Kingdee#2019"}





[2019-07-29 19:33:56.248] INFO [wTaskExecutor-13] c.y.z.c.w.t.ServiceDeployTask - /kingdee/opscripts/yzj_buluo_deploy/local_script
[2019-07-29 19:33:56.595] INFO [wTaskExecutor-13] c.y.z.c.w.t.ServiceDeployTask - /kingdee/zyy/download/PATCH/PT_USERORG_20190726143646/space/config
[2019-07-29 19:33:56.608] INFO [wTaskExecutor-13] c.y.z.c.w.t.ServiceDeployTask - sh start.sh action=deploy assignation_ip=10.10.199.124,10.10.199.126 productFamily=yzj versionId=10.0.0.0 productId=CORESERVICE domainId=USERORG app_name=space releaseId=20190726101217 Pinpoint_Agent_Switch= package_type=war projectType=jetty package_src_path=/kingdee/zyy/download/PATCH/PT_USERORG_20190726143646/space APP_MAINCLASS=0 http_port=11754 Max_Jvm_Mem=2048 Init_Jvm_Mem=1024 InnerContextPaths= ZK_server=10.10.199.195:2181,10.10.199.191:2181,10.10.199.192:2181 deploy_path=/kingdee/webapps/space deploy_user=yzj ansible_become_pass=Kingdee#2019
