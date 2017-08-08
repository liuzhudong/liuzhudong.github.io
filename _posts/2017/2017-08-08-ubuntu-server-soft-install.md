---
layout: "post"
title: "Ubuntu服务软件安装"
categories: [ubuntu server, 记录]
description: "记录最近安装Ubuntu server(16.04.2 LTS)的一些服务器软件"
keywords: ubuntu server, 软件安装, docker, nodejs
---
记录最近安装Ubuntu server(16.04.2 LTS)的一些服务器软件。

# Ubuntu服务软件安装
<p>
查看服务系统版本可以有以下几种方法:
</p>
### cat /etc/issue
```sh
$ cat /etc/issue
Ubuntu 16.04.2 LTS \n \l
```
### lsb_release
```sh
$ sudo lsb_release -a
LSB Version:	core-9.20160110ubuntu0.2-amd64:core-9.20160110ubuntu0.2-noarch:security-9.20160110ubuntu0.2-amd64:security-9.20160110ubuntu0.2-noarch
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.2 LTS
Release:	16.04
Codename:	xenial
```
### 查看Linux系统内核版本：
```sh
$ uname -r
4.4.0-79-generic
```
### apt 查询软件
```sh
$ sudo apt search docker
```
以Ubuntu 16.04.2 LTS 为例

## docker
```sh
$ sudo apt-get remove docker docker-engine

$ sudo apt-get update

$ sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

$ sudo apt-get update

$ sudo apt install docker.io

```
### 问题&配置
#### Cannot connect to the Docker daemon. Is the docker daemon running on this host?
```
$ ls -l /var/run/docker.sock
srw-rw---- 1 root docker 0 Nov 27 05:56 /var/run/docker.sock
// 就是修改高于660的权限即可
$ sudo chmod 666 /var/run/docker.sock
```

#### 配置阿里云加速
通过修改daemon配置文件/etc/docker/daemon.json来使用加速器

```
$ sudo mkdir -p /etc/docker
$ sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://c5xdtexs.mirror.aliyuncs.com"]
}
EOF
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

## docker-compose
```sh
$ sudo apt install docker-compose
```

## npm & nodejs
```sh
// npm 安装
$ sudo apt install npm
$ npm -v
// 查看npm源
$ npm config get registry
// 将npm源设置为taobao的npm源
$ npm config set registry https://registry.npm.taobao.org/
// npm 版本升级
$ sudo npm -g install npm@latest
$ npm -v
// nodejs 安装
$ sudo apt install nodejs-legacy
$ sudo npm install -g n
$ sudo n -v
// 使用或安装最新的官方发布：
$ sudo n latest
// 使用或安装稳定的正式版本：
$ sudo n stable
// 使用或安装最新的LTS正式版本：
$ sudo n lts
```
### 问题
#### n无法管理node版本
解决方案

```
// 如果你跟我一样，发现 node 版本没有任何变化，那最有可能的情况就是，你的node的安装目录和 n 默认的路径不一样。查看 node 当前安装路径：
$ which node
/usr/local/bin/node

// 而 n 默认安装路径是 /usr/local，若你的 node 不是在此路径下，n 切换版本就不能把bin、lib、include、share 复制该路径中，所以我们必须通过N_PREFIX变量来修改 n 的默认node安装路径。
$ sudo vim ~/.bash_profile
export N_PREFIX=/usr/local
export PATH=$N_PREFIX/bin:$PATH
$ source ~/.bash_profile
```

## mysql-server
```sh
// 安装mysql服务
$ sudo apt install mysql-server
// 登录mysql
$ mysql -u root -p
// 修改mysql通过服务器地址链接
$ vim /etc/mysql/mysql.conf.d/mysqld.cnf
bind-address		= 0.0.0.0
// 登录mysql
$ mysql -u root -p
// 允许远程访问设置
> use mysql;
> grant all privileges on *.* to root@"%" identified by "替换为root的密码" with grant option;
> quit;
// 重启mysql
$ sudo service mysql restart
```
### 创建用户
```
// 创建用户
mysql> INSERT INTO mysql.user (HOST, USER, authentication_string,ssl_cipher,x509_issuer,x509_subject) VALUES ( "%", "lx_block_root", PASSWORD("root123!!!"),"","","");

INSERT INTO mysql.user (HOST, USER, authentication_string,ssl_cipher,x509_issuer,x509_subject) VALUES ( "localhost", "lx_block_root", PASSWORD("root123!!!"),"","","");
// 创建数据库
mysql> CREATE DATABASE IF NOT EXISTS lr_block_data;
//授权lx_block_root用户拥有lr_block_data数据库的所有权限。
mysql> grant all privileges on lr_block_data.* to lx_block_root@"%" identified by 'root123!!!';
// 刷新系统权限
mysql> flush privileges;

```

### mysql 执行脚本文件
```sh
$ mysql -u -p –D 数据库 <【sql脚本文件路径全名】
```
PS:
> 如果在sql脚本文件中使用了use 数据库，则-D数据库选项可以忽略 <br />
> 如果【Mysql的bin目录】中包含空格，则需要使用“”包含，如：“C:\Program Files\mysql\bin\mysql” –u用户名 –p密码 –D数据库<【sql脚本文件路径全名】
>

---
