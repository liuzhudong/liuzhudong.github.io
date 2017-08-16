---
layout: "post"
title: "Ubuntu服务软件安装"
categories: [记录]
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
