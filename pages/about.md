---
layout: page
title: About
description: 开始记录
keywords: liuzhudong, 刘柱栋, jellyliu, jelly
comments: false
menu: 关于
permalink: /about/
---

## Skill Keywords

{% for category in site.data.skills %}
### {{ category.name }}
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}
