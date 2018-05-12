---
layout: post
title: 每周记录系列文档列表
description: 每周记录系列文档列表
keywords: 每周记录系列
comments: false
menu: 每周记录系列
permalink: /weekly-issue-list/
---

<section class="container posts-content">
{% assign sorted_categories = site.categories | sort %}
{% for category in sorted_categories %}
{% if category.first contains '每周记录系列'  %}

<h3> :star: 文档列表 :v: </h3>
<ol class="posts-list" id="{{ category[0] }}">
{% for post in category.last %}
<li class="posts-list-item">
<span class="posts-list-meta">{{ post.date | date:"%Y-%m-%d" }}</span>
<a class="posts-list-name" href="{{ post.url }}">{{ post.title }}</a>
</li>
{% endfor %}
</ol>
{% endif %}
{% endfor %}
</section>
