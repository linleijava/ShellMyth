# playbook内容

test.yaml
实例：

---
    - hosts: centos7
      tasks:
        - name execute date cmd
	  command: /bin/date
        - name: copy fstab to /tmp
	  copy: src=/etc/fstab dest=/tmp
	  become: yes
	  become_method: sudo
	  become_user: root # 此项默认值就是root，所以可省
	  # 上面的示例可以看出remote_user实际上并不是执行任务的绝对身份，它只是ssh连接过去的身份，只不过没有指定become的时候，它正好就用此身份来运行任务
	- name: another way to ignore the non_zero return code
	  shell: /usr/sbin/ntpdate ntp1.aliyun.com
	  ignore_errors: true

