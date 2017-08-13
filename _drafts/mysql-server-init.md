---
layout: "post"
title: "Mysql 数据库初始化配置"
categories: [mysql, 记录]
description: Mysql 数据库初始化配置及相关操作记录
keywords: mysql, server, 数据库
---

Mysql 数据库初始化配置及相关操作记录。

# Mysql 数据库初始化配置
## Mysql 安装
基于服务器系统: Ubuntu 16.04.2 LTS
```sh
$ sudo apt install mysql-server
```
安装过程中需要设置 root 登录密码。

## 配置远程连接
```sh
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

## 创建用户
```
// 创建用户
mysql> INSERT INTO mysql.user (HOST, USER, authentication_string,ssl_cipher,x509_issuer,x509_subject) VALUES ( "%", "lx_block_root", PASSWORD("root123!!!"),"","","");
mysql> INSERT INTO mysql.user (HOST, USER, authentication_string,ssl_cipher,x509_issuer,x509_subject) VALUES ( "localhost", "lx_block_root", PASSWORD("root123!!!"),"","","");
// 刷新系统权限
mysql> flush privileges;
// 创建数据库
mysql> CREATE DATABASE IF NOT EXISTS lr_block_data;
//授权lx_block_root用户拥有lr_block_data数据库的所有权限。
mysql> grant all privileges on lr_block_data.* to lx_block_root@"%" identified by 'root123!!!';
// 刷新系统权限
mysql> flush privileges;

```

## mysql 执行脚本文件
```sh
$ mysql -u -p –D 数据库 <【sql脚本文件路径全名】
```
PS:
> 如果在sql脚本文件中使用了use 数据库，则-D数据库选项可以忽略 <br />
> 如果【Mysql的bin目录】中包含空格，则需要使用“”包含，如：“C:\Program Files\mysql\bin\mysql” –u用户名 –p密码 –D数据库<【sql脚本文件路径全名】
>
