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

===
-END- :v: