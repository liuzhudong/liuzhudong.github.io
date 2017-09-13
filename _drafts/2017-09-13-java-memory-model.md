---
layout: post
title: 深入理解 Java 内存模型
categories: [Java]
description: 深入理解 Java 内存模型
keywords: java, 内存模型, java memory model
---

深入理解 Java 内存模型。

## 内存模型
* 主内存
所有的变量都存储在主内存

* 工作内存
每条线程有自己的工作内存，线程的工作内存保存了被该线程使用到的变量的主内存副本拷贝，线程对变量的所有操作都必须在工作内存中进行，不能直接读写主内存中的变量。

不同线程之间也无法直接访问对方的工作内存中的变量，线程之间的变量值得传递需要通过主内存来完成。

线程、主内存、工作内存之间的关系图:
<!-- ![thread-status](http://blog.liuzhudong.com/images/java-thread-status.jpg) -->

## 内存之间交互操作
对于下列操作指令都是原子的，不可再分的（double和long例外）
```
lock(加锁):
unlock(解锁):
read(读取):
load(加载):
use(使用):
assign(赋值):
store(存储):
write(写入):
```
