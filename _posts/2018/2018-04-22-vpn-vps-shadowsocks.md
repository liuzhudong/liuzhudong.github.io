---
layout: post
title: 搭建自己的 VPN ( VPS + Shadowsocks ) 
categories: [记录]
description: 搭建自己的 VPN ( VPS + Shadowsocks ) 
keywords: vpn,vps,shadowsocks
---
记录搭建自己的 VPN ( VPS + Shadowsocks ) 。

本记录转载至：`https://www.diycode.cc/topics/738` 。

# 购买国外的VPS

```js
https://www.vultr.com
```

* 注册账号

![create account](http://blog.liuzhudong.com/images/vpn/20180422/01.png)

* 账户充值，使用支付宝

![account bill](http://blog.liuzhudong.com/images/vpn/20180422/02.png)

* 创建Server

![create server](http://blog.liuzhudong.com/images/vpn/20180422/03.png)

* 选择服务器地址，这里选美国洛杉矶，日本东京的不稳定

![config server](http://blog.liuzhudong.com/images/vpn/20180422/04.png)

* 选择服务器系统Centos和付费套餐

![config server](http://blog.liuzhudong.com/images/vpn/20180422/05.png)

* 创建Server成功后，Servers界面会显示刚创建的Server，状态是Installing. 等几分钟，状态会变成Running

![start server](http://blog.liuzhudong.com/images/vpn/20180422/06.png)

* 进入Server详情页面

![server detail](http://blog.liuzhudong.com/images/vpn/20180422/07.png)

PS：红色圈里的就是服务器连接的IP，用户名和密码。

自此服务器就创建好了，下面就是用终端连接安装shadowsocks server啦。

# 安装 shadowsocks server

连接进入服务器执行如下操作：

```sh
cd ~
# 下载安装脚本并执行
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

选择脚本（Python、R、Go、libev），任选一个：

```js
Which Shadowsocks server you'd select:
1.Shadowsocks-Python
2.ShadowsocksR
3.Shadowsocks-Go
4.Shadowsocks-libev
Please enter a number (default 1): 3 // 输入3选择 Shadowsocks-Go 回车
```

选择Shadowsocks-Go，输入3......然后，输入密码和端口，笔者直接回车用默认：

```js
You choose = Shadowsocks-Go

Please enter password for Shadowsocks-Go
(default password: teddysun.com): // 输入你的密码，这个是shadowsocks 客户端连接输入的密码

password = teddysun.com 

Please enter a port for Shadowsocks-Go [1-65535]
(default port: 8989): // 输入你的开放的端口，这个是shadowsocks 客户端连接使用的端口

port = 8989


Press any key to start...or Press Ctrl+C to cancel // 按回车键
```

安装成功后，命令行出现：

```js
Congratulations, Shadowsocks-Go server install completed!
Your Server IP        :  45.32.73.59   // 服务器IP
Your Server Port      :  8989          // 服务器端口
Your Password         :  teddysun.com  // 连接密码
Your Encryption Method:  aes-256-cfb   // 连接加密类型
```

PS:如果安装失败重试或尝试其他脚本。

检查服务：

```sh
ps -ef | grep shadowsocks
```

# shadowsocks 客户端配置

下载客户端：

```js
// 在github上搜索shadowsocks
window 版本：https://github.com/shadowsocks/shadowsocks-windows // releases中是版本
Mac 版本：https://github.com/shadowsocks/ShadowsocksX-NG  // releases中是版本
```

根据上面的服务配置配置客户端：

![client config](http://blog.liuzhudong.com/images/vpn/20180422/08.png)

启动代理，在浏览器输入 `www.google.com` ，如果google能正常访问，证明你搭建Shadowsocks成功了！

# 安装 tcp_bbr 

## TCP BBR 拥塞控制算法

TCP BBR 是 Google 开源的 拥塞控制算法，类似锐速的单边加速工具。由于受到各方面限制，国外的vps速度不理想，偶尔有延迟、不稳定的现象出现。而bbr的作用，就是要解决这一问题。

我们只需要在vps上安装即可，参考《一键安装最新内核并开启 BBR 脚本》。

使用root用户登录，运行以下命令：

```sh
cd ~
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh
```

安装完成后，脚本会提示需要重启 VPS，输入 y 并回车后重启。

重启后，执行命令：

```sh
lsmod | grep bbr
```

返回值有 tcp_bbr 模块即说明bbr已启动。

（TCP BBR要求Linux内核4.10以上，如果安装提示内核版本太低，去《一键安装最新内核并开启 BBR 脚本》查看升级内核方法）

BBR成功安装后，shadowsocks速度有明显提升，尽管不是每个网络都能看youtube1080P视频（笔者公司无压力，在家就不行），但浏览普通外国网站很畅通。

# 服务器快照备份

Snapshot是Vultr提供的VPS快照功能，简单地说就是保存VPS状态，有需要的时候恢复。这个功能相当实用，例如安装了shadowsocks、bbr等，snapshot；然后添加多一个vps，同样要shadowsocks+bbr，这时恢复snapshot，就不用再手动安装、配置了。

进去某个server，Snapshots界面，填写Label（一个备注而已），点"Take Snapshot"：

![Take Snapshot](http://blog.liuzhudong.com/images/vpn/20180422/09.png)

![Take Snapshot](http://blog.liuzhudong.com/images/vpn/20180422/10.png)

![Take Snapshot](http://blog.liuzhudong.com/images/vpn/20180422/11.png)

PS：刚添加Snapshots，Status时Pending，等5~10分钟，状态就变成Available，快照保存成功。（期间请不要修改VPS）

---
