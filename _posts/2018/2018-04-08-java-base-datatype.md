---
layout: post
title: 深入理解Java系列 -- Java 基本数据类型
categories: [Java]
description: Java 基本数据类型详细使用
keywords: java
---
记录 Java 基本数据类型详细使用。

# Java 基本数据类型

Java 的两大数据类型:

* 内置数据类型
* 引用数据类型

## 内置数据类型

Java语言提供了八种基本类型。六种数字类型（四个整数型，两个浮点型），一种字符类型，还有一种布尔型。

### byte

* byte 数据类型是8位、有符号的，以二进制补码表示的整数；
* 最小值是 -128（-2^7）；
* 最大值是 127（2^7-1）；
* 默认值是 0；
* byte 类型用在大型数组中节约空间，主要代替整数，因为 byte 变量占用的空间只有 int 类型的四分之一；
* 例子：byte a = 100，byte b = -50。

### short

* short 数据类型是 16 位、有符号的以二进制补码表示的整数
* 最小值是 -32768（-2^15）；
* 最大值是 32767（2^15 - 1）；
* Short 数据类型也可以像 byte 那样节省空间。一个short变量是int型变量所占空间的二分之一；
* 默认值是 0；
* 例子：short s = 1000，short r = -20000。

### int

* int 数据类型是32位、有符号的以二进制补码表示的整数；
* 最小值是 -2,147,483,648（-2^31）；
* 最大值是 2,147,483,647（2^31 - 1）；
* 一般地整型变量默认为 int 类型；
* 默认值是 0 ；
* 例子：int a = 100000, int b = -200000。

### long

* long 数据类型是 64 位、有符号的以二进制补码表示的整数；
* 最小值是 -9,223,372,036,854,775,808（-2^63）；
* 最大值是 9,223,372,036,854,775,807（2^63 -1）；
* 这种类型主要使用在需要比较大整数的系统上；
* 默认值是 0L；
* 例子： long a = 100000L，Long b = -200000L。
* "L"理论上不分大小写，但是若写成"l"容易与数字"1"混淆，不容易分辩。所以最好大写。

### float

* float 数据类型是单精度、32位、符合IEEE 754标准的浮点数；
* float 在储存大型浮点数组的时候可节省内存空间；
* 默认值是 0.0f；
* 浮点数不能用来表示精确的值，如货币；
* 例子：float f1 = 234.5f。

### double

* double 数据类型是双精度、64 位、符合IEEE 754标准的浮点数；
* 浮点数的默认类型为double类型；
* double类型同样不能表示精确的值，如货币；
* 默认值是 0.0d；
* 例子：double d1 = 123.4。

### boolean

* boolean数据类型表示一位的信息；
* 只有两个取值：true 和 false；
* 这种类型只作为一种标志来记录 true/false 情况；
* 默认值是 false；
* 例子：boolean one = true。

### char

* char类型是一个单一的 16 位 Unicode 字符；
* 最小值是 \u0000（即为0）；
* 最大值是 \uffff（即为65,535）；
* char 数据类型可以储存任何字符；
* 例子：char letter = 'A'。

## 引用数据类型

* 在Java中，引用类型的变量非常类似于C/C++的指针。引用类型指向一个对象，指向对象的变量是引用变量。这些变量在声明时被指定为一个特定的类型，比如 Employee、Puppy 等。变量一旦声明后，* 类型就不能被改变了。
* 对象、数组都是引用数据类型。
* 所有引用类型的默认值都是null。
* 一个引用变量可以用来引用任何与之兼容的类型。
* 例子：Site site = new Site("Runoob")。

# 类型转换

## 自动类型转换

整型、实型（常量）、字符型数据可以混合运算。运算中，不同类型的数据先转化为同一类型，然后进行运算。
转换从低级到高级。

```
低  ------------------------------------>  高

byte,short,char—> int —> long—> float —> double
```

数据类型转换必须满足如下规则：

1. 不能对boolean类型进行类型转换。
2. 不能把对象类型转换成不相关类的对象。
3. 在把容量大的类型转换为容量小的类型时必须使用强制类型转换。
4. 转换过程中可能导致溢出或损失精度，例如：

```java
int i =128;
byte b = (byte)i;
```

因为 byte 类型是 8 位，最大值为127，所以当 int 强制转换为 byte 类型时，值 128 时候就会导致溢出。
5. 浮点数到整数的转换是通过舍弃小数得到，而不是四舍五入，例如：

```java
(int)23.7 == 23;
(int)-45.89f == -45
```

## 强制类型转换

1. 条件是转换的数据类型必须是兼容的。
2. 格式：(type)value type是要强制类型转换后的数据类型 实例：

```java
public class QiangZhiZhuanHuan{
    public static void main(String[] args){
        int i1 = 123;
        byte b = (byte)i1;//强制类型转换为byte
        System.out.println("int强制类型转换为byte后的值等于"+b);
    }
}
```

## 隐含强制类型转换

1. 整数的默认类型是 int。
2. 小数的默认类型是 double。
3. 定义 float 类型时必须在数字后面跟上 F 或者 f。

# 包装类 & 自动装箱与拆箱

集合里存放的对象都是Object类型，取出的时候需要强制类型转换为目标类型（使用泛型集合不需要），如int a = (Integer)arrayList.get(0)；然后我们就会发现，为什么要强制转换为Integer，而不是int呢？int与Integer有什么区别呢？

## 基本类型与包装类区别

int是基本类型，直接存数值；如：

```java
int i = 5；//直接在栈中分配空间，存放5这个数值
```

Integer是int的包装类，是类，拥有方法；如：

```java
Integer i = new Integer(5); //i是对象的引用变量，所以在堆内存中分配对象空间，栈中存放堆内存中对应空间的地址
```

Java有八种基本数据类型，对应八种包装类：

| 基本数据类型 | 包装类 |
| :-------- | :-------- |
| short | Short |
| int  | Integer |
| long  | Long |
| char  | Character |
| byte  | Byte |
| float |  Float |
| boolean |  Boolean |
| double |  Double |

变量的值存储在栈里，而对象存储在堆里，相比而言，堆栈更高效，这也是java保留基本类型的原因。包装类创建的对象，可以使用api提供的一些有用的方法。更为强大。

## 自动装箱与自动拆箱

自动装箱与自动拆箱在编译成class文件时就已经完成。

那我们来分析Integer i = 5;的过程；

在jdk1.5以前，这样的代码是错误的，必须要通过Integer i = new Integer(5);这样的语句实现；而在jdk1.5以后，Java提供了自动装箱的功能，只需Integer i = 5;这样的语句就能实现基本数据类型传给其包装类，JVM为我们执行了Integer i = Integer.valueOf(5);这就是Java的自动装箱。

相对应的，把基本数据从对应包装类中取出的过程就是拆箱；如

```java
Integer i = 5；
int j = i;//这样的过程就是自动拆箱
```

源码方面，用一句话总结装箱和拆箱的实现过程：

装箱过程是通过调用包装器的valueOf方法实现的，而拆箱过程是通过调用包装器的 xxxValue方法实现的。（xxx代表对应的基本数据类型）

Integer i = new Integer(xxx)和Integer i =xxx;这两种方式的区别：

* 第一种方式不会触发自动装箱的过程；而第二种方式会触发；
* 在执行效率和资源占用上的区别。第二种方式的执行效率和资源占用在一般性情况下要优于第一种情况（注意这并不是绝对的）。

## Integer 数值在[-128,127]的处理

```java
public static Integer valueOf(int i) {
    if (i >= IntegerCache.low && i <= IntegerCache.high)
        return IntegerCache.cache[i + (-IntegerCache.low)];
    return new Integer(i);
}
-----------------------------------------------------
private static class IntegerCache {
    static final int low = -128;
    static final int high;
    static final Integer cache[];

    static {
        // high value may be configured by property
        int h = 127;
        String integerCacheHighPropValue =
            VM.getSavedProperty("java.lang.Integer.IntegerCache.high");
        if (integerCacheHighPropValue != null) {
            try {
                int i = parseInt(integerCacheHighPropValue);
                i = Math.max(i, 127);
                // Maximum array size is Integer.MAX_VALUE
                h = Math.min(i, Integer.MAX_VALUE - (-low) -1);
            } catch( NumberFormatException nfe) {
                // If the property cannot be parsed into an int, ignore it.
            }
        }
        high = h;

        cache = new Integer[(high - low) + 1];
        int j = low;
        for(int k = 0; k < cache.length; k++)
            cache[k] = new Integer(j++);

        // range [-128, 127] must be interned (JLS7 5.1.7)
        assert IntegerCache.high >= 127;
    }

    private IntegerCache() {}
}
```

从这2段代码可以看出，在通过valueOf方法创建Integer对象的时候，如果数值在[-128,127]之间，便返回指向IntegerCache.cache中已经存在的对象的引用；否则创建一个新的Integer对象。

Integer、Short、Byte、Character、Long这几个类的valueOf方法的实现是类似的。

## '==' 和 equals 处理

* 当 "==" 运算符的两个操作数都是 包装器类型的引用，则是比较指向的是否是同一个对象，而如果其中有一个操作数是表达式（即包含算术运算）则比较的是数值（即会触发自动拆箱的过程）。
* 对于包装器类型，equals方法并不会进行类型转换。

# 整数的乘法溢出问题

如下问题：

```java
double dw = 1024 * 1024 * 1024 * 1024 ;
System.out.println(dw);// 结果为0
```

看了《Java虚拟机说明书》中“Java语言编程概念”中对“基本数据类型的变窄转换”的介绍才算明白了。

对于

```java
int i = 1000000;
System.out.println(i*i);
-----------------------
-727379968
-----------------------
```

的合理解释和过程应该是这样的：

i设置为1000000，在乘方时Java发现结果（1000000000000）已经超出了int基本数据类型的最大范围（2147483647），于是作了默认的类型提升（type promotion），中间结果做为long类型存放，返回结果时目标数据类型int不能够容纳下结果，于是根据Java的基础类型的变窄转换（Narrowing primitive conversion）规则，把结果宽于int类型宽度的部分全部丢弃，也就是只取结果的低32位，于是就得到了上面的结果。

下面用一个十六进制表示的例子阐释这个问题

```java
int i3 = 1000000;
System.out.println (Long.toHexString (i3*i3).toUpperCase());
System.out.println (Integer.toHexString (i3*i3).toUpperCase());
System.out.println ((int)i3*i3);
---------------------------------------------------
FFFFFFFFD4A51000
D4A51000
-727379968
---------------------------------------------------
```

截取是非常直观的。

# 内置类型的数据运算（高精度计算）

对于整数的大数相乘会存在溢出或结果位数超出指定类型的问题，同时整数的除法也会产生精度的问题。

在Java中有两个类BigInteger和BigDecimal分别表示大整数类和大浮点数类，至于两个类的对象能表示最大范围不清楚，理论上能够表示无线大的数，只要计算机内存足够大。

这两个类都在java.math.*包中。

## BigInteger

### BigInteger 构造器描述

```java
BigInteger(int)       创建一个具有参数所指定整数值的对象。
BigInteger(String)    创建一个具有参数所指定以字符串表示的数值的对象。
```

### BigInteger 方法描述

```java
add(BigInteger)        BigInteger对象中的值相加，然后返回这个对象。
subtract(BigInteger)   BigInteger对象中的值相减，然后返回这个对象。
multiply(BigInteger)   BigInteger对象中的值相乘，然后返回这个对象。
divide(BigInteger)     BigInteger对象中的值相除，然后返回这个对象。
toString()             将BigInteger对象的数值转换成字符串。
longValue()            将BigInteger对象中的值以长整数返回。
intValue()             将BigInteger对象中的值以整数返回。
doubleValue()          将BigInteger对象中的值以双精度数返回。
```

## BigDecimal

### BigDecimal 构造器描述

```java
BigDecimal(int)       创建一个具有参数所指定整数值的对象。
BigDecimal(double)    创建一个具有参数所指定双精度值的对象。
BigDecimal(long)      创建一个具有参数所指定长整数值的对象。
BigDecimal(String)    创建一个具有参数所指定以字符串表示的数值的对象。
```

### BigDecimal 方法描述

```java
add(BigDecimal)        BigDecimal对象中的值相加，然后返回这个对象。
subtract(BigDecimal)   BigDecimal对象中的值相减，然后返回这个对象。
multiply(BigDecimal)   BigDecimal对象中的值相乘，然后返回这个对象。
divide(BigDecimal)     BigDecimal对象中的值相除，然后返回这个对象。
toString()             将BigDecimal对象的数值转换成字符串。
doubleValue()          将BigDecimal对象中的值以双精度数返回。
floatValue()           将BigDecimal对象中的值以单精度数返回。
longValue()            将BigDecimal对象中的值以长整数返回。
intValue()             将BigDecimal对象中的值以整数返回。
```

其中做除法操作还涉及到小数精度问题

```java
divide(BigDecimal divisor, int scale, RoundingMode roundingMode)
// scale 为保留小数位数
// roundingMode 进位模式
```

#### RoundingMode

RoundingMode是一个枚举类，有一下几个常量：UP，DOWN，CEILING，FLOOR，HALF_UP，HALF_DOWN，HALF_EVEN，UNNECESSARY。

##### RoundingMode.UP

远离零方向舍入的舍入模式。始终对非零舍弃部分前面的数字加 1。注意，此舍入模式始终不会减少计算值的绝对值。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 6 |
| 2.5 | 3 |
| 1.6 | 2 |
| 1.1 | 2 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -2 |
| -1.6 | -2 |
| -2.5 | -3 |
| -5.5 | -6 |

##### RoundingMode.DOWN

向零方向舍入的舍入模式。从不对舍弃部分前面的数字加 1（即截尾）。注意，此舍入模式始终不会增加计算值的绝对值。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 5 |
| 2.5 | 2 |
| 1.6 | 1 |
| 1.1 | 1 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -1 |
| -1.6 | -1 |
| -2.5 | -2 |
| -5.5 | -5 |

##### RoundingMode.CEILING

向正无限大方向舍入的舍入模式。如果结果为正，则舍入行为类似于 RoundingMode.UP；如果结果为负，则舍入行为类似于 RoundingMode.DOWN。注意，此舍入模式始终不会减少计算值。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 6 |
| 2.5 | 3 |
| 1.6 | 2 |
| 1.1 | 2 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -1 |
| -1.6 | -1 |
| -2.5 | -2 |
| -5.5 | -5 |

##### RoundingMode.FLOOR

向负无限大方向舍入的舍入模式。如果结果为正，则舍入行为类似于 RoundingMode.DOWN；如果结果为负，则舍入行为类似于RoundingMode.UP。注意，此舍入模式始终不会增加计算值。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 5 |
| 2.5 | 2 |
| 1.6 | 1 |
| 1.1 | 1 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -2 |
| -1.6 | -2 |
| -2.5 | -3 |
| -5.5 | -6 |

##### RoundingMode.HALF_UP

向最接近数字方向舍入的舍入模式，如果与两个相邻数字的距离相等，则向上舍入。如果被舍弃部分 >= 0.5，则舍入行为同 RoundingMode.UP；否则舍入行为同RoundingMode.DOWN。注意，此舍入模式就是通常学校里讲的四舍五入。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 6 |
| 2.5 | 3 |
| 1.6 | 2 |
| 1.1 | 1 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -1 |
| -1.6 | -2 |
| -2.5 | -3 |
| -5.5 | -6 |

##### RoundingMode.HALF_DOWN

向最接近数字方向舍入的舍入模式，如果与两个相邻数字的距离相等，则向下舍入。如果被舍弃部分 > 0.5，则舍入行为同 RoundingMode.UP；否则舍入行为同RoundingMode.DOWN。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 5 |
| 2.5 | 2 |
| 1.6 | 2 |
| 1.1 | 1 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -1 |
| -1.6 | -2 |
| -2.5 | -2 |
| -5.5 | -5 |

##### RoundingMode.HALF_EVEN

向最接近数字方向舍入的舍入模式，如果与两个相邻数字的距离相等，则向相邻的偶数舍入。如果舍弃部分左边的数字为奇数，则舍入行为同RoundingMode.HALF_UP；如果为偶数，则舍入行为同RoundingMode.HALF_DOWN。注意，在重复进行一系列计算时，此舍入模式可以在统计上将累加错误减到最小。此舍入模式也称为“银行家舍入法”，主要在美国使用。此舍入模式类似于 Java 中对float 和double 算法使用的舍入策略。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | 6 |
| 2.5 | 2 |
| 1.6 | 2 |
| 1.1 | 1 |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | -1 |
| -1.6 | -2 |
| -2.5 | -2 |
| -5.5 | -6 |

##### RoundingMode.UNNECESSARY

用于断言请求的操作具有精确结果的舍入模式，因此不需要舍入。如果对生成精确结果的操作指定此舍入模式，则抛出 ArithmeticException。

| 输入数字 | 使用 HALF_DOWN 舍入模式将输入数字舍入为一位数 |
| :-------- | :-------- |
| 5.5 | throw ArithmeticException |
| 2.5 | throw ArithmeticException |
| 1.6 | throw ArithmeticException |
| 1.1 | throw ArithmeticException |
| 1.0 | 1 |
| -1.0 | -1 |
| -1.1 | throw ArithmeticException |
| -1.6 | throw ArithmeticException |
| -2.5 | throw ArithmeticException |
| -5.5 | throw ArithmeticException |

# 内置类型的原子操作类

原子是世界上的最小单位，具有不可分割性。比如 a=0；（a非long和double类型） 这个操作是不可分割的，那么我们说这个操作时原子操作。再比如：a++； 这个操作实际是a = a + 1；是可分割的，所以他不是一个原子操作。非原子操作都会存在线程安全问题，需要我们使用同步技术（sychronized）来让它变成一个原子操作。一个操作是原子操作，那么我们称它具有原子性。    java的concurrent包下提供了一些原子类，我们可以通过阅读API来了解这些原子类的用法。比如：AtomicInteger、AtomicLong、AtomicReference等。

java.util.concurrent.atomic 包中提供了以下原子类, 它们是线程安全的类。

原理实现时通过 CompareAndSet 来保证多线程下的正确更新。

## AtomicInteger

AtomicInteger的常用方法如下：

```java
int addAndGet(int delta)   以原子方式将输入的数值与实例中的值（AtomicInteger里的value）相加，并返回结果
boolean compareAndSet(int expect, int update)   如果输入的数值等于预期值，则以原子方式将该值设置为输入的值。
int getAndIncrement()   以原子方式将当前值加1，注意：这里返回的是自增前的值。
void lazySet(int newValue)  最终会设置成newValue，使用lazySet设置值后，可能导致其他线程在之后的一小段时间内还是可以读到旧的值。
int getAndSet(int newValue) 以原子方式设置为newValue的值，并返回旧值。
```
