---
layout: "post"
title: "Docker Remote Api操作记录"
date: "2017-08-17 16:07"
categories: Docker
description: Docker Remote Api操作记录
keywords: docker, docker remote api
---

记录 Docker Remote Api 的使用。

# Docker Remote Api操作记录

## 开启 Docker Remote Api
### Ubuntu
设置访问端口操作
```sh
$  sudo vim /lib/systemd/system/docker.service
## 修改前 ExecStart=/usr/bin/dockerd -H fd://
## 修改后 ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
## 保存
# 刷新
$ systemctl daemon-reload
# 重启服务
$ sudo service docker restart
```
设置完成之后可以按下面测试:
```sh
$ curl http://localhost:2375/version
```
输出：
```json
{
  "Version": "17.06.0-ce",
  "ApiVersion": "1.30",
  "MinAPIVersion": "1.12",
  "GitCommit": "02c1d87",
  "GoVersion": "go1.8.3",
  "Os": "linux",
  "Arch": "amd64",
  "KernelVersion": "4.4.0-89-generic",
  "BuildTime": "2017-06-23T21:19:04.990631145+00:00"
}
```
