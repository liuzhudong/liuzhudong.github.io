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

:smail: 相关文章：

* [使用sqoop工具进行数据表增量导入](https://blog.csdn.net/xichenguan/article/details/39054183)
* [sqoop定时增量导入](https://blog.csdn.net/ryantotti/article/details/14226635)


===