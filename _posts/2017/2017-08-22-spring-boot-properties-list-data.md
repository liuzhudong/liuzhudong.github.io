---
layout: post
title: Spring Boot properties配置集合数据
date: '2017-08-22 23:20'
categories:
  - Java
  - Spring Boot
description: Spring Boot properties配置集合数据
keywords: 'spring boot, properties, 数组'
---

Spring Boot properties配置集合数据。

### properties文件配置
```
szca.service.selfextres.list[0].id=
szca.service.selfextres.list[0].name=
szca.service.selfextres.list[0].age=

szca.service.selfextres.list[1].id=
szca.service.selfextres.list[1].name=
szca.service.selfextres.list[1].age=
```

### Bean类
```java
public class User{
  private int id;
  private String name;
  private int age;

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getAge() {
    return age;
  }

  public void setAge(int age) {
    this.age = age;
  }
}
```

### 配置类
```java
@Component
@ConfigurationProperties(prefix = "szca.service.selfextres")
public class SelfExtresConfig {

  private List<SelfExtRes> list = new ArrayList<>();

  public List<SelfExtRes> getSelfList(){
    return list;
  }

}

```

### 使用
```java

@Autowired
private SelfExtresConfig selfExtresConfig;

// 获取集合数据
selfExtresConfig.getSelfList();
```

---

## 参考
* [ 加载YAML](https://doc.yonyoucloud.com/doc/Spring-Boot-Reference-Guide/IV.%20Spring%20Boot%20features/23.6.1.%20Loading%20YAML.html)
