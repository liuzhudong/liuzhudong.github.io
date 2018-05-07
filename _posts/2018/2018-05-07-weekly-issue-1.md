---
layout: post
title: 每周记录第 1 期
categories: [每周记录系列]
description: 记录每周看到，学到，了解到的所有东西
keywords: 每周记录
---

记录每周看到，学到，了解到的所有东西（主要是为后面整理做备份）。

# Java NIO

简单了解了一下 java NIO 的知识点。找了一些关于 java NIO 的 code example。发现网上比较多的还是关于网络连接的部分，很少关于文件读写操作的文章。

本次搜索的目的是想实现有些配置写在文件，而现有的数据写入文件采用的还是之前的 BIO 模式读写。:star2:

:dog: 相关文章：

* [NIO 教程 http://wiki.jikexueyuan.com/project/java-nio-zh/java-nio-overview.html](http://wiki.jikexueyuan.com/project/java-nio-zh/java-nio-overview.html)
* [NIO 网络实例 https://blog.csdn.net/chenxuegui1234/article/details/17979725](https://blog.csdn.net/chenxuegui1234/article/details/17979725)
* [NIO 教程 http://tutorials.jenkov.com/java-nio/files.html](http://tutorials.jenkov.com/java-nio/files.html)
* [NIO 文件读写 https://blog.csdn.net/wangjun5159/article/details/50020351](https://blog.csdn.net/wangjun5159/article/details/50020351)

# Spring Boot Profile 配置

spring boot 关于 profile 的使用。使用 profile 来切换运行环境，可以在配置中配置不同环境的配置参数通过指定不同的 profile 来加载不同的配置参数。

jar运行方式：

```sh
java -jar xx.jar --spring.profiles.active=prod
```

:dog: 相关文章：

* [https://www.jianshu.com/p/fef49d5b380c](https://www.jianshu.com/p/fef49d5b380c)
* [https://www.jianshu.com/p/948c303b2253](https://www.jianshu.com/p/948c303b2253)

# Spring Boot 非web应用程序实例

spring boot 怎么创建非 web 应用程序。

```js
// maven pom.xml 添加jar依赖
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
</dependency>

// 程序 main class 实现 CommandLineRunner 接口
@SpringBootApplication
public class Start implements CommandLineRunner {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(Start.class);
        application.setBannerMode(Mode.OFF);
        application.run(args);
    }

    @Override
    public void run(String... args) throws Exception {
        // TODO
    }

}
```

:dog: 相关文章：

* [https://blog.csdn.net/lxh18682851338/article/details/78559595](https://blog.csdn.net/lxh18682851338/article/details/78559595)

# Spring boot 使用 @ConfigurationProperties

spring boot 关于注解 @ConfigurationProperties 的使用记录。

```js
// 为具体的实体类绑定指定的配置
// 在类代码上使用注解
@Component
@ConfigurationProperties(prefix="connection")
public class ConnectionSettings {}

// 在提供bean时使用注解
@Bean
@ConfigurationProperties(prefix = "connection")
public ConnectionSettings connectionSettings(){
    return new ConnectionSettings();
}

```

:dog: 相关文章：

* [https://blog.csdn.net/yingxiake/article/details/51263071](https://blog.csdn.net/yingxiake/article/details/51263071)

# 多台 Linux 服务器 ssh 相互无密码访问

实现 多台 Linux 服务器 ssh 相互无密码访问。采用在 A 服务器生成公私钥 ，将公钥传输给 B 服务器的方式。

```js
// server A
ssh-keygen -t rsa

ll ~/.ssh
-rw-------  1 liuzhudong  staff   3.2K May 14  2017 id_rsa  // 私钥
-rw-r--r--  1 liuzhudong  staff   746B May 14  2017 id_rsa.pub // 公钥

ssh-copy-id -i  ~/.ssh/id_rsa.pub root@192.168.17.190  // 复制 server A 公钥 到其他服务器

ssh  root@192.168.17.190 // 检验是否需要密码登录其他服务器

// 如果是 A->B,C,D... 重复执行 ssh-copy-id -i  ~/.ssh/id_rsa.pub 操作即可
// 如果是 A<->B,A<->C,C<->B ... 重复在 server A 上的操作 将生成的公钥复制到 其他指定服务器即可

```

:dog: 相关文章：

* [https://blog.csdn.net/An342647823/article/details/7245471](https://blog.csdn.net/An342647823/article/details/7245471)

# Linux Shell 远程执行命令（命令行与脚本方式）

根据上面配置好了各服务器之间 ssh 免密访问，接下来就是要实现可以远程执行命令和脚本。

```js
// 执行命令
// 基本能完成常用的对于远程节点的管理了，几个注意的点：
// 1.双引号，必须有。如果不加双引号，第二个ls命令在本地执行
// 2.分号，两个命令之间用分号隔开
ssh root@192.168.17.190 "cd /data/logs; ls -l "

// 执行脚本
// 远程执行的内容在“<< eeooff ” 至“ eeooff ”之间，在远程机器上的操作就位于其中，注意的点：
// 1. << eeooff，ssh后直到遇到eeooff这样的内容结束，eeooff可以随便修改成其他形式。
// 2. 在结束前，加exit退出远程节点
ssh root@172.18.173.193 << eeooff
set -x
if [ -d ${DEPLOY_ENV_ROOT}/peers/peer${index} ]; then
    cd ${DEPLOY_ENV_ROOT}/peers/peer${index}
    docker-compose down
    if [ $? != 0 ];then
        echo "ERROR: shutdown Server peer${index} failed "
        exit $?
    fi
fi
echo "ok"
exit
eeooff

```

:dog: 相关文章：

* [http://www.3mu.me/linux中的shell用ssh自动登录远程服务器后执行命令并自动/](http://www.3mu.me/linux中的shell用ssh自动登录远程服务器后执行命令并自动/)
* [http://www.cnblogs.com/ilfmonday/p/ShellRemote.html](http://www.cnblogs.com/ilfmonday/p/ShellRemote.html)
* [shh 命令实例指南 https://linux.cn/article-3858-1.html](https://linux.cn/article-3858-1.html)

# Linux Shell /dev/null 2>&1 详解

`> /dev/null 2>&1` 这样的写法.这条命令的意思是将标准输出和错误输出全部重定向到/dev/null中,也就是将产生的所有信息丢弃。

下面我就为大家来说一下, `command > file 2>file`  与 `command > file 2>&1` 有什么不同的地方:

`command > file 2>file` 的意思是将命令所产生的标准输出信息,和错误的输出信息送到 `file` 中. `command  > file 2>file` 这样的写法, `stdout` 和 `stderr` 都直接送到 `file` 中, `file` 会被打开两次,这样 `stdout` 和 `stderr` 会互相覆盖,这样写相当使用了 FD1 和 FD2 两个同时去抢占 `file` 的管道.

而 `command >file 2>&1` 这条命令就将 `stdout` 直接送向 `file` , `stderr` 继承了 FD1 管道后,再被送往 `file` ,此时,`file` 只被打开了一次,也只使用了一个管道FD1,它包括了 `stdout` 和 `stderr` 的内容.

从 IO 效率上,前一条命令的效率要比后面一条的命令效率要低,所以在编写shell脚本的时候,较多的时候我们会用 `command > file 2>&1` 这样的写法.

:dog: 相关文章：

* [http://blog.51cto.com/viplin/99568](http://blog.51cto.com/viplin/99568)

# Linux 下 rsync 的用法

rsync是类unix系统下的数据镜像备份工具——remote sync。

rsync是一个功能非常强大的工具，其命令也有很多功能特色选项，我们下面就对它的选项一一进行分析说明。

它的特性如下：

* 可以镜像保存整个目录树和文件系统。
* 可以很容易做到保持原来文件的权限、时间、软硬链接等等。
* 无须特殊权限即可安装。
* 快速：第一次同步时 rsync 会复制全部内容，但在下一次只传输修改过的文件。rsync 在传输数据的过程中可以实行压缩及解压缩操作，因此可以使用更少的带宽。
* 安全：可以使用scp、ssh等方式来传输文件，当然也可以通过直接的socket连接。
* 支持匿名传输，以方便进行网站镜像。

rysnc 的官方网站：[http://rsync.samba.org/](http://rsync.samba.org/)，可以从上面得到最新的版本。关于rsync算法的介绍点 [这里](http://rsync.samba.org/tech_report/node2.html)，还有 [陈皓blog](https://coolshell.cn/articles/7425.html)。

:beer: 使用实例:

```js
rsync -avz --progress --chmod=Du=rwx,Dog=rx,Fug=rw,Fo=r \
-e "ssh -lroot -p22" /data/xn-block/ 172.18.173.193:/data/liuzd/xn-block
// -a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD
// -v, --verbose 详细模式输出
// -z, --compress 对备份的文件在传输时进行压缩处理
// --progress 显示备份过程
// -e, --rsh=COMMAND 指定使用rsh、ssh方式进行数据同步
// --exclude=PATTERN 指定排除不需要传输的文件模式
// --include=PATTERN 指定不排除而需要传输的文件模式
// --exclude-from=FILE 排除FILE中指定模式的文件
// --include-from=FILE 不排除FILE指定模式匹配的文件
```

:dog: 相关文章：

* [https://blog.csdn.net/daniel_ustc/article/details/18005925](https://blog.csdn.net/daniel_ustc/article/details/18005925)

---
