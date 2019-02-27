# 功能介绍

本示例基于BIMFACE提供的服务端API和JavaScript显示组件实现了工程文件的在线浏览，基本流程如下：
1. 调用服务端API实现文件上传
2. 调用服务端API发起文件转换
3. 调用服务端API查询转换结果，每秒钟查询一次
4. 待转换成功后，调用服务端API获取ViewToken
5. 在网页中集成JavaScript显示组件，实现工程文件在线浏览

# 运行必须的组件

* JDK1.8
* Tomcat8.0
* Servlet
* Maven

# Java第三方依赖（Maven）

```xml
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>javax.servlet-api</artifactId>
	<version>3.1.0</version>
	<scope>provided</scope>
</dependency>
<dependency>
	<groupId>com.bimface</groupId>
	<artifactId>bimface-java-sdk</artifactId>
	<version>3.1.1</version>
	<classifier>all</classifier>
</dependency>
<dependency>
	<groupId>commons-fileupload</groupId>
	<artifactId>commons-fileupload</artifactId>
	<version>1.3.2</version>
</dependency>
```

# 如何在本地运行？

### 使用git下载源代码

```
git clone https://github.com/bimface/bimface-java-sample.git
```

### 修改Config

必须修改Config中的APP证书，程序才能正常运行。

```java
package com.bimface.sample;

/**
 * APP证书
 * 
 * @author bimface, 2017-03-01
 */
public class Config {

    // 通过(bimface.com)创建应用，并拿到自己的appKey和appSecret
    public final static String APP_KEY    = "请填入appKey";
    public final static String APP_SECRET = "请填入appSecret";
}
```

### 使用Maven编译JAVA程序

进入项目根目录

```
mvn clean install -DskipTests
```

### 部署到Tomcat8.0

1. 把生成的war包拷贝到Tomcat的运行目录，修改名为：sample.war
2. 启动Tomcat

### 在网页中运行

```
http://localhost:8080/sample
```