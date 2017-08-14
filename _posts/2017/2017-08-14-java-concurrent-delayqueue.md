---
layout: post
title: Java多线程高并发 -- DelayQueue
categories:
  - Java
description: DelayQueue 使用相关
keywords: 'java, DelayQueue, 多线程高并发'
---

DelayQueue 类是一个延迟的队列。

# DelayQueue
DelayQueue 类是实现 Delayed 接口的元素的一个无界阻塞队列，只有在延迟期满时才能从中提取元素。

Delayed 接口定义了getDelay(TimeUnit unit)方法。

该队列的头部是延迟期满后保存时间最长的 Delayed 元素。如果延迟都还没有期满，则队列没有头部，
并且 poll 将返回 null。当一个元素的getDelay(TimeUnit unit) 方法返回一个小于或等于零的值时，则出现期满。

> 它是无界阻塞队列，容量是无限的
> 它是线程安全的，是阻塞的
> 不允许使用 null 元素
> 加入的元素必须实现了Delayed接口

## Demo
### 定义任务类
```java
public class MyTask implements Delayed {

  private long delayTime;
  private String name;
  private CountDownLatch countDownLatch;

  public MyTask(String name, long delayTime, CountDownLatch countDownLatch) {
    this.delayTime =
        TimeUnit.NANOSECONDS.convert(delayTime, TimeUnit.MILLISECONDS) + System.nanoTime();
    this.name = name;
    this.countDownLatch = countDownLatch;
  }

  public void doTask() {
    System.out.println(name + " do :::" + delayTime);
    countDownLatch.countDown();
  }

  @Override
  public long getDelay(TimeUnit unit) {
    return unit.convert(delayTime - System.nanoTime(), TimeUnit.NANOSECONDS);
  }

  @Override
  public int compareTo(Delayed o) {
    if (o == null || !(o instanceof MyTask)) {
      return 1;
    }

    if (this.equals(o)) {
      return 0;
    }

    MyTask myTask = (MyTask) o;
    if (this.delayTime > myTask.delayTime) {
      return 1;
    } else if (this.delayTime < myTask.delayTime) {
      return -1;
    } else {
      return 0;
    }
  }
}

```

### 定义两个具体线程实现多线程调度
#### TaskRun
```java
public class TaskRun implements Runnable {

  private DelayQueue<MyTask> tasks;
  private CountDownLatch countDownLatch;

  public TaskRun(
      DelayQueue<MyTask> tasks, CountDownLatch countDownLatch) {
    this.tasks = tasks;
    this.countDownLatch = countDownLatch;
  }

  @Override
  public void run() {
    Random random = new Random();
    for (int i = 0; i < 10; i++) {
      tasks.put(new MyTask("TASK-" + i, random.nextInt() & 0xFFFF, countDownLatch));
      try {
        Thread.sleep(100);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
  }
}
```
#### TaskListener
```java
public class TaskListener implements Runnable {

  private DelayQueue<MyTask> tasks;

  public TaskListener(
      DelayQueue<MyTask> tasks) {
    this.tasks = tasks;
  }

  @Override
  public void run() {
    MyTask task;
    while (true) {
      try {

        System.out.println("tasks take");
        task = tasks.take();
        task.doTask();
      } catch (InterruptedException e) {
        e.printStackTrace();
        break;
      }
    }
  }
}
```

### 测试类
```java
public class DelayQueueTest {

  @Test
  public void tst() throws Exception {

    final DelayQueue<MyTask> tasks = new DelayQueue<>();
    final CountDownLatch countDownLatch = new CountDownLatch(10);
    Thread thread1 = new Thread(new TaskRun(tasks, countDownLatch));
    Thread thread2 = new Thread(new TaskListener(tasks));
    thread1.start();
    thread2.start();
    countDownLatch.await();
    System.out.println("end");

  }
}
```
测试结果
```
tasks take
TASK-4 do :::46079281309799
tasks take
TASK-3 do :::46090825505495
tasks take
TASK-6 do :::46092169115848
tasks take
TASK-1 do :::46106846458826
tasks take
TASK-7 do :::46109232178788
tasks take
TASK-8 do :::46113470560038
tasks take
TASK-0 do :::46124663531135
tasks take
TASK-9 do :::46133784127346
tasks take
TASK-2 do :::46139671593335
tasks take
TASK-5 do :::46140956235065
tasks take
end
```
