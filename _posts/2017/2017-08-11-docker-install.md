---
layout: post
title: Docker 安装
categories: Docker
description: 记录 ubuntu 下的 docker 安装
keywords: 'docker install, ubuntu'
---

记录ubuntu下的docker安装。

# Docker 安装配置

## Docker 安装
基于服务器系统: Ubuntu 16.04.2 LTS

按下列命令执行:
```sh
$ sudo apt-get remove docker-ce docker.io docker docker-engine

$ sudo apt-get update

$ sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

$ sudo apt-get update

$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

$ sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22

$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

$ sudo apt-get update
## 安装最新版本
$ sudo apt-get install docker-ce
## 安装指定版本
$ sudo apt-get install docker-ce=<VERSION>
## 查看有哪些版本可安装
$ apt-cache madison docker-ce
## 查看安装的 Docker 版本
$ docker version
```
至此 Docker 就安装成功。

## 配置
### 阿里云加速设置
通过修改daemon配置文件/etc/docker/daemon.json来使用加速器。

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
具体的阿里云加速地址见自己阿里云提供的地址。
> [https://dev.aliyun.com/search.html](https://dev.aliyun.com/search.html)

### 修改 docker 数据存放路径

```sh
sudo systemctl stop docker
sudo vim /lib/systemd/system/docker.service
#ExecStart=/usr/bin/dockerd -H fd:// 这项后面追加 --graph=/data/docker 并保存
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## docker-compose 安装
```sh
$ sudo apt install docker-compose
$ docker-compose version
```

## 问题&解决
### Cannot connect to the Docker daemon. Is the docker daemon running on this host?
```
$ ls -l /var/run/docker.sock
srw-rw---- 1 root docker 0 Nov 27 05:56 /var/run/docker.sock
// 就是修改高于660的权限即可
$ sudo chmod 666 /var/run/docker.sock
```

## 参考
* [https://docs.docker.com/engine/installation/#time-based-release-schedule](https://docs.docker.com/engine/installation/#time-based-release-schedule)
