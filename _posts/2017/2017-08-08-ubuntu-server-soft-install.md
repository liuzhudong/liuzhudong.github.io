---
layout: "post"
title: "Ubuntu服务软件安装"
categories: [记录]
description: "记录最近安装Ubuntu server(16.04.2 LTS)的一些服务器软件"
keywords: ubuntu server, 软件安装, docker, nodejs
---

记录最近安装Ubuntu server(16.04.2 LTS)的一些服务器软件。

# ubuntu 相关命令记录

## 查看服务系统版本

### cat /etc/issue

```sh
cat /etc/issue
# Ubuntu 16.04.2 LTS \n \l
```

### lsb_release

```sh
sudo lsb_release -a
# LSB Version:	core-9.20160110ubuntu0.2-amd64:core-9.20160110ubuntu0.2-noarch:security-9.20160110ubuntu0.2-amd64:security-9.20160110ubuntu0.2-noarch
# Distributor ID:	Ubuntu
# Description:	Ubuntu 16.04.2 LTS
# Release:	16.04
# Codename:	xenial
```

### 查看Linux系统内核版本

```sh
uname -r
# 4.4.0-79-generic
```

## apt 查询软件

```sh
sudo apt search docker
```

# Ubuntu 相关软件记录

## 挂载数据盘

```sh
sudo fdisk -l   # 根据磁盘大小来确定要挂载的磁盘，假定是/dev/vdb
sudo mkfs.ext4 /dev/vdb
sudo mkdir -p /data
sudo mount /dev/vdb /data
sudo chmod 777 /data
```

## nodejs 安装

### 安装nodejs 6.x版本，当前版本6.11.0

```sh
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs
```

### npm & nodejs

```sh
# npm 安装
$ sudo apt install npm
$ npm -v
# 查看npm源
$ npm config get registry
# 将npm源设置为taobao的npm源
$ npm config set registry https://registry.npm.taobao.org/
# npm 版本升级
$ sudo npm -g install npm@latest
$ npm -v
# nodejs 安装
$ sudo apt install nodejs-legacy
$ sudo npm install -g n
$ sudo n -v
# 使用或安装最新的官方发布：
$ sudo n latest
# 使用或安装稳定的正式版本：
$ sudo n stable
# 使用或安装最新的LTS正式版本：
$ sudo n lts
```

### n无法管理node版本解决方案

```sh
# 如果你跟我一样，发现 node 版本没有任何变化，那最有可能的情况就是，你的node的安装目录和 n 默认的路径不一样。查看 node 当前安装路径：
$ which node
# /usr/local/bin/node
# 而 n 默认安装路径是 /usr/local，若你的 node 不是在此路径下，n 切换版本就不能把bin、lib、include、share 复制该路径中，所以我们必须通过N_PREFIX变量来修改 n 的默认node安装路径。
$ sudo vim ~/.bash_profile
export N_PREFIX=/usr/local
export PATH=$N_PREFIX/bin:$PATH
$ source ~/.bash_profile
```

## mysql 安装

```sh
sudo apt-get install mysql-server
```

### 配置mysql

[mysqld.cnf](http://blog.liuzhudong.com/files/config/mysql/mysqld.conf)

```sh
# 禁止apparmor限制mysqld的读写
sudo ln -s /etc/apparmor.d/usr.sbin.mysqld  /etc/apparmor.d/disable/usr.sbin.mysqld
sudo service apparmor reload

# 修改配置和数据目录
sudo service mysql stop # 停
# 上传配置 mysqld.cnf 到 /etc/mysql/mysql.conf.d/，里面重新设置了datadir tmpdir
sudo mkdir -p /data/mysqldata  # 数据文件的目录
sudo chmod 777 /data/mysqldata
sudo mkdir -p /data/mysqltmp   # 临时文件的目录
sudo chmod 777 /data/mysqltmp
sudo mv /var/lib/mysql/* /data/mysqldata # 把原来的/var/lib/mysql下的数据文件移到
sudo service mysql start # 启

```


## redis 安装

```sh
sudo apt-get install redis-server
```

### 配置redis

[redis.conf](http://blog.liuzhudong.com/files/config/redis/redis.conf)

```sh
sudo service redis stop  # 停
# 上传配置 redis.conf 到 /etc/redis
sudo service redis start  # 启
```

## nginx 安装

```sh
sudo apt-get install nginx
```

### 配置nginx

[nginx_default.conf](http://blog.liuzhudong.com/files/config/nginx/nginx_default.conf)

```sh
# 上传配置 nginx_default.conf 到 /etc/nginx/conf.d/ 查看配置nginx -t
# 把ssl证书复制到nginx对应的目录
nginx -s reload
```




