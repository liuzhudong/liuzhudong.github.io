---
layout: post
title: 磁盘挂载
date: '2017-08-22 23:09'
categories:
  - Linux
description: 服务器挂载数据盘
keywords: '磁盘挂载, 服务器, ubuntu'
---

Linux磁盘挂载(Ubuntu)。

## 服务器挂载数据盘
```
$ sudo fdisk -l   # 根据磁盘大小来确定要挂载的磁盘，假定是/dev/vdb
$ sudo mkfs.ext4 /dev/vdb
$ sudo mkdir -p /data
$ sudo mount /dev/vdb /data
$ sudo chmod 777 /data
```
