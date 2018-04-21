---
layout: post
title: 深入理解Java系列 -- Java 内存溢出解决方法
categories: [Java]
description: Java 内存溢出解决方法
keywords: java
---
Java 内存溢出解决方法记录。

# 导致的原因

java.lang.OutOfMemoryError 的原因大都出于以下原因：JVM内存过小、程序不严密，产生了过多的垃圾。

导致OutOfMemoryError异常的常见原因有以下几种：

* 内存中加载的数据量过于庞大，如一次从数据库取出过多数据
* 集合类中有对对象的引用，使用完后未清空，使得JVM不能回收
* 代码中存在死循环或循环产生过多重复的对象实体
* 使用的第三方软件中的BUG
* 启动参数内存值设定的过小

此错误常见的错误提示：

* java.lang.OutOfMemoryError: PermGen space
* java.lang.OutOfMemoryError: Java heap space

# 解决方法

## 增加jvm的内存大小

* 在执行某个class文件时候，可以使用java -Xmx256M aa.class来设置运行aa.class时jvm所允许占用的最大内存为256M
* 对tomcat容器，可以在启动时对jvm设置内存限度

```js
// 可以在catalina.bat中添加：
set CATALINA_OPTS=-Xms128M -Xmx256M
set JAVA_OPTS=-Xms128M -Xmx256M
或者把%CATALINA_OPTS%和%JAVA_OPTS%代替为-Xms128M -Xmx256M
```

## 优化程序

代码优化和检查点：

* 检查代码中是否有死循环或递归调用。
* 检查是否有大循环重复产生新对象实体。
* 检查对数据库查询中，是否有一次获得全部数据的查询。一般来说，如果一次取十万条记录到内存，就可能引起内存溢出。这个问题比较隐蔽，在上线前，数据库中数据较少，不容易出问题，上线后，数据库中数据多了，一次查询就有可能引起内存溢出。因此对于数据库查询尽量采用分页的方式查询。
* 检查List、MAP等集合对象是否有使用完后，未清除的问题。List、MAP等集合对象会始终存有对对象的引用，使得这些对象不能被GC回收。

## tomcat中java.lang.OutOfMemoryError: PermGen space异常处理

PermGen space的全称是Permanent Generation space,是指内存的永久保存区域,这块内存主要是被JVM存放Class和Meta信息的,Class在被Loader时就会被放到PermGen space中, 它和存放类实例(Instance)的Heap区域不同,GC(Garbage Collection)不会在主程序运行期对PermGen space进行清理，所以如果你的应用中有很多CLASS的话,就很可能出现PermGen space错误, 这种错误常见在web服务器对JSP进行pre compile的时候。如果你的WEB APP下都用了大量的第三方jar, 其大小超过了jvm默认的大小(4M)那么就会产生此错误信息了。 

```js
// 可以在catalina.bat中设置java运行时MaxPermSize大小：
JAVA_OPTS="-server -XX:PermSize=64M -XX:MaxPermSize=128m"
```

PS：将相同的第三方jar文件移置到tomcat/shared/lib目录下，这样可以达到减少jar 文档重复占用内存的目的。

---