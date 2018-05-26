---
layout: "post"
title: "ubuntu 创建桌面快捷方式"
categories: [记录]
description: "记录ubuntu 创建桌面快捷方式"
keywords: ubuntu
---

记录ubuntu 创建桌面快捷方式。

# ubuntu 下创建应用程序的桌面快捷方式

## 创建文件

```
~$ cd /usr/share/applications
~$ vim eclipse.desktop
```
	加入如下内容
```
[Desktop Entry]
Encoding=UTF-8
Name=eclipse
Comment=Eclipse IDE
Exec=/home/liuzd/eclipse/eclipse
Icon=/home/liuzd/eclipse/icon.xpm
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
```

<p>

对上面的命令中的几条稍作解释：<br>
    Exec代表应用程序的位置【视实际情况修改】<br>
    Icon代表应用程序图标的位置【视实际情况修改】<br>
    Terminal的值为false表示启动时不启动命令行窗口，值为true表示启动命令行窗口【建议为false】<br>
    Categories这里的内容决定创建出的起动器在应用程序菜单中的位置，按照上面的写法创建的起动器将出现在应用程序－Internet中，以此类推，如果想在应用程序－办公中创建起动器，上述最后一行应该写成：Categories=Application;Office;
<p>

## 复制文件到桌面

```
～$ cp eclipse.desktop ~/Desktop
```


