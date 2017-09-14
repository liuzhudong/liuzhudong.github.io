---
layout: post
title: 深入理解 Java Volatile关键字
categories: [Java]
description: 深入理解 Java Volatile关键字
keywords: java, volatile
---

深入理解 Java Volatile 关键字，必须先要理解 Java 的内存工作模式。

* [ Java 内存模型]()

## Volatile 关键字
volatileJ是 Java 提供的最轻量级的同步机制。
其作用是保证一个变量在任何线程读写都是与主内存是同步的，即线程A更新了 volatile 变量M的值，线程B在使用volatile 变量M时能获取到最新的值（即和线程A的变量M值是一致的），即所谓的可见性。

### Volatile内存操作的特殊规则
volatile变量之所以能在多线程中保持变量可见性，是由于java内存模型对于volatile变量专门定义了一些特殊规则，
从而java虚拟机在编译和运行时都会对其进行特殊处理。

* 规定下面的内存操作指令的顺序是固定的：
```
读取值: read --> load --> use
写入值: assign --> store --> write
```
PS: 内存操作指令参见java内存模型

* 规定使用volatile变量禁止指令重排序，即volatile变量内存指令操作(写入赋值操作)不允许插入其他操作指令，从而保证了有序性

在多线程的情况下，由上面的规则保证了每个线程使用变量必须先从主内存同步变量值再使用，在给变量赋值时必须同步回主内存。并且volatile禁止指令重排序，所以可以保证每个线程对volatile变量的操作是有序的，多线程下也是按顺序操作。

### 对比
* 同步机制和锁比较
```
volatile的同步机制在性能上要优于锁（synchronize关键字或java.util.concurrent包里面的锁）
但是由于java虚拟机对锁实行的许多消除和优化，所以很难量化的认为volatile会比synchronize快多少
volatile没有使用锁机制所有不会造成阻塞
```

* 和普通变量比较
```
volatile变量的读操作的性能消耗与普通变量几乎没什么差别
volatile变量写操作会比普通变量慢一些，因为在写操作时插入许多内存屏障指令来保证有序执行
```

## 参考
* 深入理解 Java 虚拟机（第12章 Java 内存模型与线程 12.3 Java 内存模型）
* Java 并发编程实战（第3章 对象的共享 3.1.4 Volatile 变量）
