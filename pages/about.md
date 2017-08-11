---
layout: page
title: 关于我的介绍
description: 关于我
keywords: liuzhudong, 刘柱栋, jellyliu, jelly
comments: false
menu: 关于
permalink: /about/
---

有助于你进一步了解我哦。

# 我的简介
我是一个什么的人。

## 技能
我会那些技能，能做什么事。

{% for category in site.data.skills %}
### {{ category.name }}
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}
