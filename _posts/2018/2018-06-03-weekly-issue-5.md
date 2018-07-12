---
layout: post
title: 每周记录第 5 期
categories: [每周记录系列]
description: 记录每周看到，学到，了解到的所有东西
keywords: 每周记录
---

:zap: 记录每周看到，学到，了解到的所有东西（主要是为后面整理做备份）。:thumbsup:

---

# 椭圆曲线加密算法（ECDSA）

java 的代码实现: [EcdsaCrypto.java](https://github.com/liuzhudong/crypto-utils/blob/master/java/src/main/java/com/jelly/code/crypto/ecdsa/EcdsaCrypto.java)

golang 的代码实现: [ecdsa-crypto.go](https://github.com/liuzhudong/crypto-utils/blob/master/go/ecdsa-crypto.go)

```js
// openssl 验证公私钥命令
openssl ec -in privatekey.pem -text -noout // 打印私钥(pem)
openssl ec -in publickey.pem -pubin -text -noout // 打印公钥(pem)

openssl rsa -inform DER -pubin -in publickey.der -text // 打印公钥(der)
openssl pkey -inform DER -in privatekey.der -text // 打印私钥(der)
```

:beer: 相关文章：

* [https://www.jianshu.com/p/676a0eb33d31](https://www.jianshu.com/p/676a0eb33d31)

# kmv 模型计算了解

# Hyperledger fabric ca 的 ldap 配置了解

# fabric ca 的一个 enroll 流程

# Shell 编程中 Shift 的用法

位置参数可以用shift命令左移。比如shift 3表示原来的$4现在变成$1，原来的$5现在变成$2等等，原来的$1、$2、$3丢弃，$0不移动。不带参数的shift命令相当于 `shift 1` 。

非常有用的 Unix 命令:shift。我们知道，对于位置变量或命令行参数，其个数必须是确定的，或者当 Shell 程序不知道其个数时，可以把所有参数一起赋值给变量$*。若用户要求 Shell 在不知道位置变量个数的情况下，还能逐个的把参数一一处理，也就是在 $1 后为 $2,在 $2 后面为 $3 等。在 shift 命令执行前变量 $1 的值在 shift 命令执行后就不可用了。

Shift 命令还有另外一个重要用途, Bsh 定义了9个位置变量，从 $1 到 $9,这并不意味着用户在命令行只能使用9个参数，借助 shift 命令可以访问多于9个的参数。

Shift 命令一次移动参数的个数由其所带的参数指定。例如当 shell 程序处理完前九个命令行参数后，可以使用 shift 9 命令把 $10 移到 `$1` 。

===
-- END --