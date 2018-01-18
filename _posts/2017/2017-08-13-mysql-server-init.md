---
layout: post
title: Mysql 数据库初始化配置
categories: Mysql
description: Mysql 数据库初始化配置及相关操作记录
keywords: 'mysql, server, 数据库'
---

Mysql 数据库相关操作记录。

# Mysql 数据库初始化配置
## Mysql 安装

* ubuntu 系统

```sh
sudo apt install mysql-server
```

* centos 系统

```
sudo yum install -y mysql-server
```

安装过程中需要设置 root 登录密码。

## 配置远程访问

* ubuntu 系统

```sh
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
bind-address		= 0.0.0.0
sudo service mysql restart
```

## 创建用户

```
INSERT INTO mysql.user (HOST, USER, authentication_string,ssl_cipher,x509_issuer,x509_subject)
VALUES ( "%", "jelly", PASSWORD("jellypw123"),"","","");
FLUSH PRIVILEGES;
```

## 数据库用户授权

```
GRANT ALL PRIVILEGES ON mydb.* TO jelly@"%" IDENTIFIED BY 'jellypw123';
FLUSH PRIVILEGES;
```

## 执行脚本文件

```
mysql -u -p –D 数据库 <【sql脚本文件路径全名】
```

PS:

```
如果在sql脚本文件中使用了use 数据库，则-D数据库选项可以忽略 <br />
如果【Mysql的bin目录】中包含空格，则需要使用“”包含，
如：“C:\Program Files\mysql\bin\mysql” –u用户名 –p密码 –D数据库<【sql脚本文件路径全名】
```

## 解决插入0000-00-00日期失败问题

```sh
show variables like '%sql_mode%';

## 结果
| sql_mode      | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |

## 更新 去掉:NO_ZERO_IN_DATE,NO_ZERO_DATE
set global sql_mode="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION";

```

## 禁止apparmor限制mysqld的读写

ubuntu

```
sudo ln -s /etc/apparmor.d/usr.sbin.mysqld  /etc/apparmor.d/disable/usr.sbin.mysqld
sudo service apparmor reload
```

## 修改配置和数据目录

[mysqld.cnf](http://blog.liuzhudong.com/files/config/mysql/mysqld.cnf)

```
sudo service mysql stop # 停
# 上传配置 mysqld.cnf 到 /etc/mysql/mysql.conf.d/，里面重新设置了datadir tmpdir
sudo mkdir -p /data/mysqldata  # 数据文件的目录
sudo chmod 777 /data/mysqldata
sudo mkdir -p /data/mysqltmp   # 临时文件的目录
sudo chmod 777 /data/mysqltmp
sudo mv /var/lib/mysql/* /data/mysqldata # 把原来的/var/lib/mysql下的数据文件移到
sudo service mysql start # 启
```


