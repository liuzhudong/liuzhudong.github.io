---
layout: post
title: 深入理解Java系列 -- Queue (队列)
categories: [Java, Java 集合系列]
description: Java Queue 介绍
keywords: java
---

Java Queue使用指南。

# Queue 接口

```java
public interface Queue<E> extends Collection<E> {
    boolean add(E e); // 插入元素到队尾（比offer多抛出一个因容量满了插入失败的异常）
    boolean offer(E e); // 插入元素到队尾
    E remove(); // 移除并返回队列头元素(如果队列为空 throw Exception)
    E poll(); // 移除并返回队列头元素(如果队列为空 return null)
    E element(); // 返回队列头元素(如果队列为空 throw Exception)
    E peek(); // 返回队列头元素(如果队列为空 return null)
}
```

使用demo:

```java

//add()和remove()方法在失败的时候会抛出异常(不推荐)
Queue<String> queue = new LinkedList<String>();
//添加元素
queue.offer("a");
queue.offer("b");
System.out.println(queue.size());

System.out.println("poll="+queue.poll()); //返回第一个元素，并在队列中删除
System.out.println(queue.size());

System.out.println("element="+queue.element()); //返回第一个元素
System.out.println(queue.size());

System.out.println("peek="+queue.peek()); //返回第一个元素
System.out.println(queue.size());

```

