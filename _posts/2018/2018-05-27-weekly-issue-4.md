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

===
-END- :v: