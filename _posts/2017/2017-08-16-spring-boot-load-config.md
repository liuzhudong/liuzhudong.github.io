---
layout: post
title: Spring Boot 加载配置
date: '2017-08-16 23:32'
categories:
  - Java
  - Spring Boot
description: spring boot 加载配置项
keywords: 'spring boot, load config'
---

Spring Boot 加载配置。

# Spring Boot 加载配置
Spring Boot 支持多种外部配置方式

* 命令行参数
* 来自java:comp/env的JNDI属性
* java系统属性（System.getProperties()）
* 操作系统环境变量
* RandomValuePropertySource配置的random.*属性值
* jar包外部的application-{profile}.properties或application.yml(带spring.profile)配置文件
* jar包内部的application-{profile}.properties或application.yml(带spring.profile)配置文件
* jar包外部的application.properties或application.yml(不带spring.profile)配置文件
* jar包内部的application.properties或application.yml(不带spring.profile)配置文件
* @Configuration注解类上的@PropertySource
* 通过SpringApplication.setDefaultProperties指定的默认属性
