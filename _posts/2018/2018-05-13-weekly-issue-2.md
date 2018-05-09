---
layout: post
title: 每周记录第 2 期
categories: [每周记录系列]
description: 记录每周看到，学到，了解到的所有东西
keywords: 每周记录
---

:zap: 记录每周看到，学到，了解到的所有东西（主要是为后面整理做备份）。:thumbsup:

# JAVA 的 Collections 类中 shuffle 的用法

`Collections.shuffle` 方法实现随机打乱原来的顺序，和洗牌一样。

```java
public class ShuffleTest {  
    public static void main(String[] args) {  
        List<Integer> list = new ArrayList<Integer>();  
        for (int i = 0; i < 10; i++)  
            list.add(new Integer(i));  
        System.out.println("打乱前:");  
        System.out.println(list);  
  
        for (int i = 0; i < 5; i++) {  
            System.out.println("第" + i + "次打乱：");  
            Collections.shuffle(list);  
            System.out.println(list);  
        }  
    }  
}
// 输出结果：
// 打乱前:
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
// 第0次打乱：
// [6, 3, 2, 0, 8, 1, 7, 5, 4, 9]
// 第1次打乱：
// [6, 2, 3, 0, 8, 5, 7, 4, 9, 1]
// 第2次打乱：
// [1, 7, 9, 4, 6, 0, 2, 5, 3, 8]
// 第3次打乱：
// [0, 4, 2, 8, 9, 1, 3, 7, 5, 6]
// 第4次打乱：
// [8, 1, 3, 0, 7, 9, 4, 2, 5, 6]  
```

:dog: 相关文章：

* [https://blog.csdn.net/ameyume/article/details/6282051](https://blog.csdn.net/ameyume/article/details/6282051)

# Go 语言 string、int、int64 互相转换

```go
//string到int
int,err:=strconv.Atoi(string)

//string到int64
int64, err := strconv.ParseInt(string, 10, 64)

//int到string
string:=strconv.Itoa(int)

//int64到string
string:=strconv.FormatInt(int64,10)
```

:dog: 相关文章：

* [https://blog.csdn.net/pkueecser/article/details/50433460](https://blog.csdn.net/pkueecser/article/details/50433460)


---