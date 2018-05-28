---
layout: post
title: 每周记录第 3 期
categories: [每周记录系列]
description: 记录每周看到，学到，了解到的所有东西
keywords: 每周记录
---

:zap: 记录每周看到，学到，了解到的所有东西（主要是为后面整理做备份）。:thumbsup:

# 区块链积分代币相关资料

* [Hyperledger Fabric 积分代币上链方案](https://cloud.tencent.com/developer/article/1066053)
* [Netkiller Blockchain 手札](http://www.netkiller.cn/blockchain/index.html)
* [shim.ChaincodeStubInterface 接口](http://www.netkiller.cn/blockchain/hyperledger/chaincode/ch16s06.html)
* [代币实现](http://www.netkiller.cn/blockchain/hyperledger/chaincode/chaincode.example.html#chaincode.token)
* [Hyperledger fabric 银行应用探索](http://www.netkiller.cn/blockchain/solution/bank.html)

# Linux 命令后台运行

linux命令后台运行:

```js
1. command & ： 后台运行，你关掉终端会停止运行
2. nohup command & ： 后台运行，你关掉终端也会继续运行
```

:dog: 相关文章：

* [https://www.cnblogs.com/lwm-1988/archive/2011/08/20/2147299.html](https://www.cnblogs.com/lwm-1988/archive/2011/08/20/2147299.html)

# 使用 Git 克隆指定分支的代码

```js
// clone 分支 lianrong代码
// 本地文件夹命名为 risk-control-task-lianrong
git clone -b lianrong git@39.108.71.125:BigData/risk-control-task.git risk-control-task-lianrong
```

# Spark RDD 操作 map 与 flatmap 的区别

map()是将函数用于RDD中的每个元素，将返回值构成新的RDD。

flatmap()是将函数应用于RDD中的每个元素，将返回的迭代器的所有内容构成新的RDD。

```js

```

:beer: 相关文章:

* [https://blog.csdn.net/shenshendeai/article/details/57081673](https://blog.csdn.net/shenshendeai/article/details/57081673)

# canal 实现 mysql 数据库的同步操作

详情参考 [canal](https://github.com/alibaba/canal)

# sqoop mysql to hive 增量同步

Google 搜索 `sqoop mysql to hive 增量同步`

想解决的问题：用 sqoop 实现 mysql 数据库表数据增量同步到 hive 表，而不是每次全量同步。

:smile: 相关文章：

* [使用sqoop工具进行数据表增量导入](https://blog.csdn.net/xichenguan/article/details/39054183)
* [sqoop定时增量导入](https://blog.csdn.net/ryantotti/article/details/14226635)

# Spring容器中的Bean几种初始化方法和销毁方法的先后顺序

在spring 初始化或销毁 bean 对象时的一些 `init` 或 `shutdown` 操作。

```js
// spring 配置实现
// 通过实现InitializingBean/DisposableBean 接口来定制初始化之后/销毁之前的操作方法；
// 通过<bean> 元素的 init-method/destroy-method属性指定初始化之后 /销毁之前调用的操作方法；
// 在指定方法上加上@PostConstruct或@PreDestroy注解来制定该方法是在初始化之后还是销毁之前调用。

// spring 执行优先顺序
// Bean在实例化的过程中：Constructor > @PostConstruct >InitializingBean > init-method
// Bean在销毁的过程中：@PreDestroy > DisposableBean > destroy-method
```

:beer: 相关文章：

* [Spring容器中的Bean几种初始化方法和销毁方法的先后顺序](https://blog.csdn.net/caihaijiang/article/details/8629725)
* [通过Spring @PostConstruct 和 @PreDestroy 方法 实现初始化和销毁bean之前进行的操作](https://blog.csdn.net/topwqp/article/details/8681497)
* [源码解析：init-method、@PostConstruct、afterPropertiesSet孰先孰后](http://sexycoding.iteye.com/blog/1046993)

# JAVA NIO 实现遍历一个文件夹

BIO 下 `file.list()` 同样的效果在 NIO 的实现。

```java
final List<Path> files = new LinkedList<>();
Path certificatePath = Paths.get(mspBasePath, key);
try (Stream<Path> ds = Files.list(certificatePath)) {
    Iterator<Path> paths = ds.iterator();
    while (paths.hasNext()) {
        files.add(paths.next());
    }
}
```

# Spring boot 整合 Dubbo

记录 spring boot 整合 dubbo 的实现。

:sunny: 相关文章：

* [Spring-boot:5分钟整合Dubbo构建分布式服务](https://www.cnblogs.com/jaycekon/p/SpringBootDubbo.html)
* [dubbo-spring-boot-starter GitHub ](https://github.com/alibaba/dubbo-spring-boot-starter)

# kubernetes 安装

这一周研究了一下用 `kubeadm` 安装 k8s集群。

安装部署相关配置和文档在这里：[k8s-install](https://github.com/liuzhudong/k8s-install)

接下来需要深入的了解一下 kubernetes 的架构和相关文档。

:smail: 相关文章：

* [这个人里面有好几篇关于 kubernetes 相关的文章](https://blog.frognew.com)
* [Kubernetes1.10中部署dashboard以及常见问题解析](https://www.kubernetes.org.cn/3834.html)
* [Kubernetes 中文文档](https://www.kubernetes.org.cn/k8s)
* [Kubernetes 官方文档](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)

# Docker commit 命令

`docker commit` 命令可以用来基于当前正在 `running` 的 docker 容器创建镜像。

```js
docker ps
// dccb1deca0e1 nginx "nginx -g 'daemon ..."   3 days ago Up 3 days     nginx

docker commit dccb1deca0e1 nginx:v1.2-test
```

===
-END- :v: