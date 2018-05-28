---
layout: "post"
title: "ubuntu 下面安装 JDK "
categories: [记录]
description: "记录 ubuntu 下面安装 JDK "
keywords: ubuntu
---

记录 ubuntu 下面安装 JDK 。

# ubuntu 下面安装JDK

## 一 自己下载JDK安装

```js
// 官网下载JDK文件
http://www.oracle.com/technetwork/java/javase/downloads/index-jsp-138363.html

// 解压文件
sudo mkdir /usr/lib/jvm
sudo tar zxvf jdk-7u21-linux-i586.tar.gz -C /usr/lib/jvm
cd /usr/lib/jvm

// 添加环境变量
sudo vim ~/.bashrc
// 加入如下内容
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_45
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

// 配置默认JDK版本
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_45/bin/java 300
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_45/bin/javac 300
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.8.0_45/bin/jar 300
sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/jdk1.8.0_45/bin/javah 300
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/jdk1.8.0_45/bin/javap 300
sudo update-alternatives --config java
// 若是初次安装 JDK， 将提示
// There is only one alternative in link group java (providing /usr/bin/java): /usr/lib/jvm/java/bin/java 无需配置。
// 若是非初次安装，将有不同版本的 JDK 选项。

// 测试
java -version
// java version "1.7.0_21"
// Java(TM) SE Runtime Environment (build 1.7.0_21-b11)
// Java HotSpot(TM) Server VM (build 23.21-b01, mixed mode)
```

===
