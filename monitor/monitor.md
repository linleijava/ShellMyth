### Monitor

#### 命令篇

* CPU监控 top

* 虚拟内存监控 vmstat

测试参数讲解：
```
r  ：表示运行队列，如果运行队列过大，表示你的CPU很繁忙，一般会造成CPU使用率很高

b  ：表示阻塞的进程数

swpd ：虚拟内存已使用的大小，如果大于0，表示你的机器物理内存不足了，如果不是程序内存泄露的原因，那么你该升级内存了或者把耗内存的任务迁移到其他机器

free  ：空闲的物理内存的大小

buff  ： 系统占用的缓存大小

cache ：直接用来记忆我们打开的文件,给文件做缓冲

si  ：每秒从磁盘读入虚拟内存的大小，如果这个值大于0，表示物理内存不够用或者内存泄露了

us ：用户CPU时间

sy ：系统CPU时间

so ： 每秒虚拟内存写入磁盘的大小，如果这个值大于0，同上。

sy ： 系统CPU时间，如果太高，表示系统调用时间长，例如是IO操作频繁。  

id  ： 空闲 CPU时间，一般来说，id + us + sy = 100  

wa: IO等待时间百分比 wa的值高时，说明IO等待比较严重，这可能由于磁盘大量作随机访问造成，也有可能磁盘出现瓶颈（块操作）。 id: 空闲时间百分比

```
* 列出打开的文件 lsof

* 网络包分析器 tcpdump

* 网络状态统计 netstat

* 监控Linux 磁盘I/O  iotop

