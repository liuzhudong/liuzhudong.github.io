---
layout: post
title: Java Thread 基础
categories: Java
description: 记录Java Thread的基础点
keywords: java, thread
---

记录Java Thread的基础点。

# 线程的实现
线程的定义有两种方式

* 继承Thread类
* 实现Runnable接口

## 线程的启动
无论是继承Thread类还是实现Runnable接口，线程的启动方式都是：
```java
Thread thread = new Thread();
thread.start();
// 或者
Thread runnable = new Thread(new Runnable());
runnable.start();
```

## run()
线程实际运行调用的是run()方法。

* 其中Thread类中的run() 实际是调用传入Runnable对象的run()方法

```java
@Override
public void run() {
    if (target != null) {
        target.run();
    }
}
```

## 线程状态
```java
NEW, // 新建，创建后尚未启动的线程处于这种状态

RUNNABLE, // 运行
          // 处于这种状态的线程有可能正在执行也有可能正在等待CPU分配执行时间

BLOCKED, // 阻塞

WAITING, // 无限期等待
         // 处于这种状态CPU不会分配执行时间
         // 需要其他线程唤醒

TIMED_WAITING, // 限期等待
               // 处于这种状态CPU不会分配执行时间
               // 不需要其他线程唤醒，在一定时间之后会由系统自动唤醒

TERMINATED; // 结束，线程已经结束执行
```
线程状态转换关系图:
![thread-status](images/java-thread-status.jpg)

## 线程的属性和方法
### 设置优先级
```java
public final void setPriority(int newPriority)
```
每个类都有自己的优先级，一般property用1-10的整数表示，默认优先级是5，优先级最高是10；优先级高的线程并不一定比优先级低的线程执行的机会高，只是执行的机率高；默认一个线程的优先级和创建他的线程优先级相同。

### sleep
```java
public static native void sleep(long millis) throws InterruptedException;
public static void sleep(long millis, int nanos) throws InterruptedException
```
当前线程睡眠/millis的时间（millis指定睡眠时间是其最小的不执行时间，因为sleep(millis)休眠到达后，无法保证会被JVM立即调度）；sleep()是一个静态方法(static method) ，所以他不会停止其他的线程也处于休眠状态；线程sleep()时不会失去拥有的对象锁。作用：保持对象锁，让出CPU，调用目的是不让当前线程独自霸占该进程所获取的CPU资源，以留一定的时间给其他线程执行的机会；

### yield
```java
public static native void yield();
```
让出CPU的使用权，给其他线程执行机会、让同等优先权的线程运行（但并不保证当前线程会被JVM再次调度、使该线程重新进入Running状态），如果没有同等优先权的线程，那么yield()方法将不会起作用。

它仅能是一个线程从运行状态转换到可运行状态，而不是等待或阻塞状态。

###　join
```java
public final void join() throws InterruptedException

public final synchronized void join(long millis)
    throws InterruptedException

public final synchronized void join(long millis, int nanos)　throws InterruptedException
```
使用该方法的线程会在此之间执行完毕后再往下继续执行。

### object.wait()
```java
// 存在对象
Object obj ;
// 使用
synchronized(obj){
    obj.wait();
}
```
当一个线程执行到wait()方法时，他就进入到一个和该对象相关的等待池(Waiting Pool)中，同时失去了对象的机锁—暂时的，wait后还要返还对象锁。当前线程必须拥有当前对象的锁，如果当前线程不是此锁的拥有者，会抛出IllegalMonitorStateException异常,所以wait()必须在synchronized 代码块中调用。

### object.notify()/notifyAll()
唤醒在当前对象等待池中等待的第一个线程/所有线程。notify()/notifyAll()也必须拥有相同对象锁，否则也会抛出IllegalMonitorStateException异常。

