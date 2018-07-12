---
layout: post
title: CDH 大数据环境安装 ( CDH 5.14.2)
categories: [大数据]
description: CDH 大数据环境安装
keywords: CDH,Hadoop
---

CDH 大数据环境安装。

# CDH 大数据环境安装文档 ( CDH 5.14.2)

* 重装系统 CentOS 7.4 64位 (``所有节点``)

四个节点信息：

```
111.112.110.60      10.104.199.179  cdh-master
111.112.112.115     10.104.5.85     cdh-slave1
111.112.111.124     10.104.35.19    cdh-slave2
111.112.111.229     10.135.69.214   cdh-slave3
```

采用统一密钥登录：cdh.txt (`ssh -i ~/.ssh/cdh.tx root@111.112.110.60`)

* 系统升级 (``所有节点``) (可选)

如果觉得安装的系统版本想要到最新版，可进行升级处理：

```sh
yum update
```

* 挂载硬盘 (``所有节点``)

```sh
sudo mkfs.ext4 /dev/vdb
sudo mount /dev/vdb /data
sudo chmod 777 /data
sudo mkdir -p /data/software
df -h
echo '/dev/vdb /data ext4    defaults    0  0' >> /etc/fstab

```

* 修改主机名称 (``所有节点``)

```sh
hostnamectl set-hostname  cdh-master
hostnamectl set-hostname  cdh-slave1
hostnamectl set-hostname  cdh-slave2
hostnamectl set-hostname  cdh-slave3
```

* 修改网络 (``所有节点``)

```sh
# 编辑网络配置新增 HOSTNAME 配置，注意对应好各自节点
vim /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=cdh-master
# HOSTNAME=cdh-slave1
# HOSTNAME=cdh-slave2
# HOSTNAME=cdh-slave3

source /etc/sysconfig/network
```

* 修改 hosts (``所有节点``)

```sh
vim /etc/hosts # 这个在腾讯云服务器好像只是临时生效，系统重启就没了
vim /etc/cloud/templates/hosts.redhat.tmpl  # 这个在腾讯云服务器是永久生效的配置

# 加入下列配置
10.104.199.179 cdh-master
10.104.5.85    cdh-slave1
10.104.35.19   cdh-slave2
10.135.69.214  cdh-slave3

# 重启网络
service network restart
```

* 关闭防火墙 (``所有节点``)

```sh
# 所有节点执行 检查防火墙状态
firewall-cmd --state
# not running 不需要关闭

# 关闭防火墙
systemctl stop firewalld.service
systemctl disable firewalld.service

```

* 关闭 SELINUX (``所有节点``)

```sh
# 所有节点执行 检查状态
/usr/sbin/sestatus -v
# SELinux status:                 disabled 不需要关闭

# 关闭 SELINUX
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

```

* 配置 ntp 服务 (``所有节点``)

```sh
yum install ntp
systemctl start ntpd.service        # 启动 ntp
systemctl enable ntpd.service       # 加入开机启动
systemctl status ntpd.service       # 查看 ntp 状态
systemctl is-enabled ntpd.service   # ntp 是否开机启动
ntpdate -u pool.ntp.org             # 使用ntpdate手动同步一下时间, 并检查ntp的状态
# 5 Jun 17:04:48 ntpdate[3180]: adjust time server 120.25.108.11 offset 0.006747 sec

```

* 重启服务器  (``所有节点``)

* ssh 免密登录各主机 (``所有节点``)

```sh
# 所有节点执行
ssh-keygen -t rsa

# 将所有节点的 ~/.ssh/id_rsa.pub 复制到 主节点的 ~/.ssh/authorized_keys 中
# 在主节点执行， ~/.ssh/cdh.txt（为服务器本身的登录密钥）
scp -i ~/.ssh/cdh.txt ~/.ssh/authorized_keys root@10.104.5.85:~/.ssh
scp -i ~/.ssh/cdh.txt ~/.ssh/authorized_keys root@10.104.35.19:~/.ssh
scp -i ~/.ssh/cdh.txt ~/.ssh/authorized_keys root@10.135.69.214:~/.ssh

# 测试 验证 ssh 
ssh cdh-master
ssh cdh-slave1
ssh cdh-slave2
ssh cdh-slave3

```

* 安装 JDK (``所有节点``)

```sh
# 主节点执行
cd /data/software

# 下载jdk安装包
# jdk1.7: http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html
# jdk1.8: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

# 下面以 jdk1.7 安装包为例
# 如果下面的 安装包文件名称与下载不匹配，请按实际下载调整执行命令
# 复制 安装包 到其他节点
scp jdk-7u80-linux-x64.tar.gz root@cdh-slave1:/data/software
scp jdk-7u80-linux-x64.tar.gz root@cdh-slave2:/data/software
scp jdk-7u80-linux-x64.tar.gz root@cdh-slave3:/data/software

# 下面的命令 所有节点执行
cd /data/software
tar zxvf jdk-7u80-linux-x64.tar.gz
mkdir -p /usr/java
mv jdk1.7.0_80/ /usr/java
# 编辑环境变量，在 /etc/profile 尾部追加配置
vim /etc/profile
# java setting
JAVA_HOME=/usr/java/jdk1.7.0_80
JRE_HOME=$JAVA_HOME/jre
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export JAVA_HOME JRE_HOME PATH CLASSPATH
# java setting end

# 配置生效
source /etc/profile

# 测试
java -version
env | grep _HOME

```

* 安装 Mysql (``主节点``)

```sh
cd /data/software
# 下载 mysql 安装包
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-common-5.7.21-1.el7.x86_64.rpm
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-libs-5.7.21-1.el7.x86_64.rpm
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-client-5.7.21-1.el7.x86_64.rpm
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-server-5.7.21-1.el7.x86_64.rpm
wget http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz

# 删除自带的 mariadb
# 查看安装信息
rpm -qa | grep mariadb
# 根据查找到的软件包信息卸载
rpm -e mariadb-libs* --nodeps
# 删除
yum -y remove maria*

yum install libnuma*

# 安装 Mysql
rpm -ivh mysql-community-common-5.7.21-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.21-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.21-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.21-1.el7.x86_64.rpm

# 修改 mysql 数据存放到 data 下面
vim /etc/my.cnf
datadir=/data/mysqldata

# 修改 mysql root 密码
service mysqld start
grep 'temporary password' /var/log/mysqld.log # 找到root的登录密码
mysql -u root -p  # 用找到的密码登录
alter user 'root'@'localhost' identified by 'Root123!!!'; # 更新 root 密码

# 授权远程访问
grant all privileges on *.* to 'root'@'%' identified by 'Root123!!!' with grant option;
flush privileges;

# 建数据库（用于后边组件安装）
create database hive DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database oozie DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database hue DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database amon DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database risk DEFAULT CHARSET utf8 COLLATE utf8_general_ci; # 这个是业务数据库

```

* 安装 Cloudera Manager Server 和 Agent (``主节点``)

```sh

cd /data/software
# 下载 cdh 相关安装包 这里下的是 cdh 5.14.2 版本
wget http://archive.cloudera.com/cm5/cm/5/cloudera-manager-centos7-cm5.14.2_x86_64.tar.gz
wget http://archive.cloudera.com/cdh5/parcels/5.14.2/CDH-5.14.2-1.cdh5.14.2.p0.3-el7.parcel
wget http://archive.cloudera.com/cdh5/parcels/5.14.2/CDH-5.14.2-1.cdh5.14.2.p0.3-el7.parcel.sha1
wget http://archive.cloudera.com/cdh5/parcels/5.14.2/manifest.json

# 修改文件名称
mv CDH-5.14.2-1.cdh5.14.2.p0.3-el7.parcel.sha1 CDH-5.14.2-1.cdh5.14.2.p0.3-el7.parcel.sha

# 解压 cm 安装包
tar zxvf cloudera-manager-centos7-cm5.14.2_x86_64.tar.gz
mv cm-5.14.2 cloudera /opt

# 复制 cdh parcel 到指定路径
mkdir -p /opt/cloudera/parcel-repo/
cp /data/software/CDH-5.14.2-1.cdh5.14.2.p0.3-el7.parcel /opt/cloudera/parcel-repo/
cp /data/software/CDH-5.14.2-1.cdh5.14.2.p0.3-el7.parcel.sha /opt/cloudera/parcel-repo/
cp /data/software/manifest.json /opt/cloudera/parcel-repo/
ll /opt/cloudera/parcel-repo/

# 解压 mysql 的 jdbc 驱动安装包
tar zxvf mysql-connector-java-5.1.45.tar.gz
mkdir -p /usr/share/java/
cp mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar /usr/share/java/mysql-connector-java.jar
cp mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar  /opt/cm-5.14.2/share/cmf/lib/

# // 初始化CM5的数据库
# // 需要输入 root 密码 Root123!!!
# // 需要设置 scm 用户密码：Scm123!!!
# // 查看配置文件，发现信息已写入
/opt/cm-5.14.2/share/cmf/schema/scm_prepare_database.sh mysql -uroot -p scm scm

# 查看上面配置的 db 信息
cat /opt/cm-5.14.2/etc/cloudera-scm-server/db.properties

# // Agent配置
vim /opt/cm-5.14.2/etc/cloudera-scm-agent/config.ini
server_host=cdh-master
cloudera_mysql_connector_jar=/usr/share/java/mysql-connector-java.jar

# // 同步Agent到其他节点(主节点)
cd /opt
tar zcvf cm-5.14.2.tar.gz cm-5.14.2
scp -r /opt/cm-5.14.2.tar.gz root@cdh-slave1:/opt/
scp -r /opt/cm-5.14.2.tar.gz root@cdh-slave2:/opt/
scp -r /opt/cm-5.14.2.tar.gz root@cdh-slave3:/opt/

# 在 其他节点执行
cd /opt
tar zxvf cm-5.14.2.tar.gz
mv cm-5.14.2.tar.gz /data/software

# 在 所有节点 创建cloudera-scm用户
useradd --system --home=/opt/cm-5.14.2/run/cloudera-scm-server/ --no-create-home --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm

# // 启动相关脚本
/opt/cm-5.14.2/etc/init.d/cloudera-scm-server start    # // 主节点
/opt/cm-5.14.2/etc/init.d/cloudera-scm-agent start     # // 所有节点
# // 同样可以使用stop, restart

# 用浏览器打开下面地址
# http://111.112.110.60:7180/cmf/login
# 初始账户密码：admin / admin
# 修改 admin 密码为：LrAdmin123
# 接下来在浏览器按照引导安装 cdh

```

* 相关配置需要注意

``` 
hive 的 hdfs 默认路径：/data/user/hive/warehouse
```

## 中间出现的问题修复

* 警告处理

```sh 
# 所有节点执行
echo 10 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled

# 上面执行完之后就可以在浏览器点击重新检查主机
# 下面是为了保证主机重启之后配置是生效的
vim /etc/sysctl.conf
vm.swappiness = 0

vim /etc/rc.local
echo never > /sys/kernel/mm/transparent_hugepage/defrag 
echo never > /sys/kernel/mm/transparent_hugepage/enabled

```

* hue 数据库连接配置不成功

错误: Unexpected error. Unable to verify database connection .

由于缺少libxslt库.

```sh
cd /data/software
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-libs-compat-5.7.21-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-compat-5.7.21-1.el7.x86_64.rpm
yum install libxslt-devel.x86_64
yum install libxslt-python.x86_64

```

* hue 服务启动失败

查看日志判断是否是下列问题：(`注意安装服务配置在哪台主机`)

```sh
# 如果是没有 HTTPD 则:
yum install httpd

# 如果是 mod_ssl.so: cannot open shared object file, 则:
yum install mod_ssl


```

* Permission denied: user=anonymous, access=WRITE, inode="/user":hdfs:supergroup:drwxr-xr-x

```sh 
# 权限不够
hadoop fs -chmod 777 /user
```

* $ACCUMULO_HOME 警告处理

```bash
# 主节点执行
sudo su - hdfs
vim ~/.bash_profile 
# 加入如下配置
ACCUMULO_HOME=/var/lib/accumulo
export ACCUMULO_HOME

mkdir -p /var/lib/accumulo
source ~/.bash_profile 

```

* sqoop 执行报错 ==>> java.io.IOException: Cannot run program "mysqldump": error=2, No such file or directory

```bash
# 主节点
which mysqldump
# /usr/bin/mysqldump
cp /usr/bin/mysqldump /data/software

# 复制到其他节点
scp -r /data/software/mysqldump root@cdh-slave1:/data/software

# 其他节点执行
mv /data/software/mysqldump /usr/bin
mysqldump --help

```

===

-- END --
