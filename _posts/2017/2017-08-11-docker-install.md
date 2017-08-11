---
layout: post
title: Docker 安装
categories:
  - docker
  - Linux
  - ubuntu
  - 记录
description: 记录ubuntu下的docker安装
keywords: 'docker install, ubuntu'
---

记录ubuntu下的docker安装。

# Docker 安装
基于服务器系统: Ubuntu 16.04.2 LTS

按下列命令执行:
```sh
$ sudo apt-get remove docker.io docker docker-engine

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

```


## 参考
* [https://docs.docker.com/engine/installation/#time-based-release-schedule](https://docs.docker.com/engine/installation/#time-based-release-schedule)
