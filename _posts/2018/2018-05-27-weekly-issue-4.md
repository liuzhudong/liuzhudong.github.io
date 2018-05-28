---
layout: post
title: 每周记录第 4 期
categories: [每周记录系列]
description: 记录每周看到，学到，了解到的所有东西
keywords: 每周记录
---

:zap: 记录每周看到，学到，了解到的所有东西（主要是为后面整理做备份）。:thumbsup:

# Mysql group_concat() 函数

`group_concat()` 能将相同的行组合起来。

```js
select
card_index_id,
group_concat(range_rule) as range_rules, // 默认按 `,` 隔开
group_concat(range_value separator '; ') as range_values // 通过 separator '; ' 指定分隔符
from grading_card_index_range
group by card_index_id
```

# Aviator 表达式执行器

Aviator 是一个 java 表达式执行器。

```java
Object obj = AviatorEvaluator.exec("3.45 < x && x <= 4.32", dd);
System.out.println(obj.getClass().getName()); // java.lang.Boolean
System.out.println(obj.toString()); // false

String expression = "a + ( b + c ) * 2";
Map<String, Object> env = new HashMap<>(3);
env.put("a", 2L);
env.put("b", 2L);
env.put("c", 2D);
obj = AviatorEvaluator.execute(expression, env);
System.out.println(obj.getClass().getName()); // java.lang.Double
System.out.println(obj.toString()); // 10.0

Expression e = AviatorEvaluator.compile(expression);

System.out.println( e.getVariableFullNames()); // [a, b, c]
System.out.println( e.getVariableNames()); // [a, b, c]

double ddd = Math.log(5);
System.out.println(ddd); // 1.6094379124341003
ddd = Math.log10(5);
System.out.println(ddd); // 0.6989700043360189

Map<String, Object> env1 = new HashMap<>(3);
env1.put("a", 5);
Object object = AviatorEvaluator.execute("math.log(a)", env1);
System.out.println(object.toString()); // 1.6094379124341003
```

:beer: 相关文章：

* [主题：Aviator——开源轻量级、高性能的表达式求值器](http://www.iteye.com/topic/701496)

# Java 中 StringBuilder 清空方法

清空有3种方法：

1. 新生成一个，旧的由系统自动回收
2. 使用delete
3. 使用setLength

```java
// 新生成一个，旧的由系统自动回收
StringBuilder strb ;
int size = 16;
for(){
    strb = new StringBuilder(size);
}

// 使用delete
StringBuilder strb = new StringBuilder(size);
for(){
    strb.delete(0,strb.length());
}

// 使用setLength
StringBuilder strb = new StringBuilder(size);
for(){
    strb.setLength(0);
}

```

# Kubernetes 入门指南

一篇介绍 Kubernetes 的文章：[Kubernetes 入门指南](http://senlinzhan.github.io/2017/11/27/k8s/)

# Hive UNION 使用

hive union 或 union all 将多个SELECT语句的结果集合并为一个独立的结果集。

语法定义：

```sql
select_statement UNION [ALL | DISTINCT] select_statement UNION [ALL | DISTINCT] select_statement ...
```

```js
// 格式
select * from a
union (union all)
select * from b;
```

union 和 union all 的区别是，union 会对多个结果集进行去重复处理。

# Git 查看各个 branch 之间的关系图

```js
git log --graph --decorate --oneline --simplify-by-decoration --all
// 说明：
// --decorate 标记会让git log显示每个commit的引用(如:分支、tag等)
// --oneline 一行显示
// --simplify-by-decoration 只显示被branch或tag引用的commit
// --all 表示显示所有的branch，这里也可以选择，比如我指向显示分支AB的关系，则将--all替换为branchA branchB
```

# Docker volume 不能使用相对路径

```js
docker run -v data:/data image:tag // data 这里docker会当做 volume 的name不是一个路径
docker run -v ./data:/data image:tag // 会报错
docker run -v ~/work/data:/data image:tag //使用绝对路径
```

PS:

* 使用相对路径，比如 `-v tmp:/var/output`，会将 tmp-rpm 解释成为 volume 的 name
* 使用相对路径并且带 `/` ，比如 `cd ~`再 `-v workspace/tmp:/var/output`，会报错，因为 volume name 只允许 `[a-zA-Z0-9][a-zA-Z0-9_.-]`
* 使用绝对路径，比如 `-v ~/workspace/tmp:/var/output`，会正确地将 tmp 文件夹映射到容器里面
* 为什么不能使用相对路径呢，原因：docker cli 和 docker daemon 可能不在一台机器上，那么就无法解析相对路径。

:beer: 相关文章：

* [docker volume 使用相对路径](https://sfwn.me/2017/02/12/docker-volume-relative-path/)


===
-END- :v: