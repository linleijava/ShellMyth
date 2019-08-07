


{
"ansible_become_user": "root", //提权用户
"ansible_become_pass": "123456", //提权密码
"ansible_become_method": "su", //提权方法
"ansible_ssh_user": "yzj", // 前提是免密登录
"working_hosts": "app12,app11,app10",
"cluster_name": "ossdev", // 实例名
"mode": "SENTINAL" // 集群安装模式
}

- hosts: localhost
  connection: local
  tasks:
  - add_host:
      name: "{{ item }}"
      group: "dns"
    with_items: "{{ hosts.split(',') }}"
    tags: dns

- name: add dns
  gather_facts: true
  hosts: "dns"
  become: yes
  vars:
    DNSLIST: "{{ dns_servers.split(',') }}"
  tasks:
   - name: backup /etc/resolv.conf
     shell: /bin/cp -f /etc/resolv.conf /etc/resolv.conf.bak
   - name: add dns to /etc/resolv.conf
     shell: sed -i "1i nameserver {{ item }}" /etc/resolv.conf
     loop: "{{ DNSLIST }}"




ansible-playbook add_dns.yml -e '{"hosts":"10.10.182.170,10.10.182.171,10.10.182.172,10.10.182.173,10.10.182.174,10.10.182.175,10.10.182.176,10.10.182.177,10.10.182.178,10.10.182.179,10.10.182.180,10.10.182.181,10.10.182.182,10.10.182.183,10.10.182.184,10.10.182.185,10.10.182.186,10.10.182.187,10.10.182.188,10.10.182.189,10.10.182.190,10.10.182.191,10.10.182.192,10.10.182.193,10.10.182.194,10.10.182.195,10.10.182.196,10.10.182.197,10.10.182.198,10.10.182.199,10.10.182.200,10.10.182.201", "dns_servers":"10.10.182.200,10.10.182.201", "ansible_become_user":"root", "ansible_become_method":"sudo"}'
