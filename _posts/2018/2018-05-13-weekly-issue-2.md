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

# MySQL 导出表结构

直接使用 mysql 命令导出数据库表结构。

```js
// 导出数据库 risk 的所有表结构
mysqldump -uroot -p -d risk > risk.sql
// 导出数据库 xn_block_sync 的 blocks 表结构
mysqldump -u root -p -d xn_block_sync blocks > blocks.sql

// 导出数据库 xn_block_sync 的所有表结构和数据
mysqldump -u root -p xn_block_sync > xn_block_sync.sql
// 导出数据库 xn_block_sync 的 blocks 表结构和数据
mysqldump -u root -p xn_block_sync blocks > xn_block_sync_blocks.sql
```

:beer: 相关文章：

* [http://www.cnblogs.com/tangtianfly/archive/2012/03/14/2396194.html](http://www.cnblogs.com/tangtianfly/archive/2012/03/14/2396194.html)

# hive 创建表 | 删除表 | 截断表

记录 hive 关于 创建表 | 删除表 | 截断表 的语法。:star:

```js
// 简单创建表
create table table_name (
  id                int,
  dtDontQuery       string,
  name              string
)

// 创建带有分区的表
create table table_name (
  id                int,
  dtDontQuery       string,
  name              string
)
partitioned by (date string)

// 常用的创建表
// [ROW FORMAT DELIMITED]关键字，是用来设置创建的表在加载数据的时候，支持的列分隔符。不同列之间用一个'\001'分割,集合(例如array,map)的元素之间以'\002'隔开,map中key和value用'\003'分割。
// [STORED AS file_format]关键字是用来设置加载数据的数据类型,默认是TEXTFILE，如果文件数据是纯文本，就是使用 [STORED AS TEXTFILE]，然后从本地直接拷贝到HDFS上，hive直接可以识别数据。
CREATE TABLE login(
     userid BIGINT,
     ip STRING, 
     time BIGINT)
 PARTITIONED BY(dt STRING)
 ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
 STORED AS TEXTFILE;

// 创建外部表
// 如果数据已经存在HDFS的'/user/hadoop/warehouse/page_view'上了，如果想创建表，指向这个路径，就需要创建外部表
CREATE EXTERNAL TABLE page_view(
     viewTime INT, 
     userid BIGINT,
     page_url STRING, 
     referrer_url STRING,
     ip STRING COMMENT 'IP Address of the User',
     country STRING COMMENT 'country of origination')
 COMMENT 'This is the staging page view table'
 ROW FORMAT DELIMITED FIELDS TERMINATED BY '\054'
 STORED AS TEXTFILE
 LOCATION '/user/hadoop/warehouse/page_view';

// 指定数据库创建表
// 如果不指定数据库，hive会把表创建在default数据库下，假设有一个hive的数据库mydb,要创建表到mydb
CREATE TABLE mydb.pokes(foo INT,bar STRING);
// 或者是
use mydb; //把当前数据库指向mydb
CREATE TABLE pokes(foo INT,bar STRING);

// 复制表结构
CREATE TABLE empty_table_name LIKE table_name;

// create-table-as-selectt (CTAS)
// CTAS创建的表是原子性的，这意味着，该表直到所有的查询结果完成后，其他用户才可以看到完整的查询结果表。
// CTAS唯一的限制是目标表，不能是一个有分区的表，也不能是外部表。
// 简单的方式
CREATE TABLE new_key_value_store
AS
SELECT (key % 1024) new_key, concat(key, value) key_value_pair FROM key_value_store;
// 复杂的方式
CREATE TABLE new_key_value_store
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile AS
SELECT (key % 1024) new_key, concat(key, value) key_value_pair
FROM key_value_store
SORT BY new_key, key_value_pair;

// 删除表
// 删除表会移除表的元数据和数据，而HDFS上的数据，如果配置了Trash，会移到.Trash/Current目录下。
// 删除外部表时，表中的数据不会被删除。
DROP TABLE table_name;
DROP TABLE IF EXISTS table_name;

// 截断表
// 从表或者表分区删除所有行，不指定分区，将截断表中的所有分区，也可以一次指定多个分区，截断多个分区。
TRUNCATE TABLE table_name;
TRUNCATE TABLE table_name PARTITION (dt='20080808');

```

:dog: 相关文章：

* [https://www.cnblogs.com/ggjucheng/archive/2013/01/04/2844393.html](https://www.cnblogs.com/ggjucheng/archive/2013/01/04/2844393.html)

---