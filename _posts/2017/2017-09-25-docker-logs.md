---
layout: post
title: Docker 日志管理
categories: [Docker]
description: 记录Docker日志管理
keywords: docker, logs, 日志管理
---

记录Docker日志管理。

# Docker 日志管理

## docker logs日志清理
docker 日志文件默认采用`json-file`记录到`/var/lib/docker/containers/containerID/containerID-json.log`。
其中`containerID`为容器ID

查找容器日志相关命令：
```sh
## 查看具体容器日志路径 LogPath
docker inspect containerID

## 
find /var/lib/docker/containers -type f -name "*-json.log" |xargs ls -lh
```

清理日志文件：
```sh
## 清理之前可以先备份或其他操作
## containerID为容器ID
cat /dev/null >/var/lib/docker/containers/containerID/containerID-json.log
```
