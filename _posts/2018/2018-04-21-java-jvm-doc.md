---
layout: post
title: 深入理解Java系列 -- JVM 调优等相关记录
categories: [Java]
description: JVM 一些要注意点记录
keywords: java, jvm , jvm 调优
---
记录 JVM 调优和底层一些要注意的点。

# java 执行时的参数配置

## 堆内存

```js
-Xms3m  // 最小堆内存 3m
-Xmx3m  // 最大堆内存 3m
-XX:+HeapDumpOnOutOfMemoryError // 在发生内存溢出错误时保存内存快照
-XX:HeapDumpPath=/path/file.hprof // 保存内存快照的路径指定
```

# java 内存溢出实现

## 堆内存溢出

```java
// 可以循环创建对象或大的对象 (使用直接内存读取大文件也会导致内存溢出)
// 内存溢出 执行时设置 -Xms -Xmx
List<Object> objs = new ArrayList<>();
while (true) {
    objs.add(new Object());
}

```

## 栈溢出

```java
// 可以递归调用方法，这样随着栈深度的增加，JVM 维持着一条长长的方法调用轨迹
int num = 0;

private void stackOverFlowTest() {
num++;
this.stackOverFlowTest();
}
```

## 堆内存快照分析工具

### IBM HeapAnalyzer

下载地址：

```js
https://www.ibm.com/developerworks/community/groups/service/html/communityview?communityUuid=4544bafe-c7a2-455f-9d43-eb866ea60091
```

下载下来是一个 haxxx.jar （xxx是版本数字）文件，可以使用命令执行：

```js
java -jar haxxx.jar
```

### jhat

JDK自带的jhat命令，jhat是用来分析java堆的命令，可以将堆中的对象以html的形式显示出来，包括对象的数量，大小等等，并支持对象查询语言。

```js
jhat -port 5000 heap.hrof // heap.hrof 是快照文件
```

当服务启动完成后，我们就可以在浏览器中，通过 `http://localhost:5000/` 进行访问。

PS: 一般来说，应用程序的dump文件都是很大的，jdk自带命令难以分析这些大文件。在实际的生产环境下，我们必须要借助第三方工具，才能快速打开这些大文件。

---
