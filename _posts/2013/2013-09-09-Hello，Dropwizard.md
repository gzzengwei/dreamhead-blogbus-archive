---
layout: post
title: Hello，Dropwizard
author: dreamhead
date: 2013-09-09 18:57:00 +0800
tags: [ 'dropwizard' ]
categories: [ 'dropwizard' ]
---

[Dropwizard](http://dropwizard.codahale.com/)是Java世界里给人带来新思维的一个框架，它在主页上如是说：

Dropwizard is a Java framework for developing ops-friendly, high-performance, RESTful web services.

这句话不足以概括Dropwizard的新思维，在我看来，Dropwizard的新，在于它把轻量级的开发/部署的概念带回了Java世界。我们用个最简单的例子来体验一下Dropwizard。

首先要声明一点的是，Dropwizard集成了众多开源框架，所以，这里看到的许多API并不是Dropwizard本身的API。

因为Dropwizard侧重点在于服务，所以，我们来开发一个打招呼的服务。你已经看到了这里它的长项是RESTful的服务，所以，我们先写一个Resource：

import com.google.common.base.Optional;

import javax.ws.rs.GET;  
import javax.ws.rs.Path;  
import javax.ws.rs.Produces;  
import javax.ws.rs.QueryParam;  
import javax.ws.rs.core.MediaType;

@Path("/consent")  
@Produces(MediaType.APPLICATION\_JSON)  
public class HelloResource {  
 &nbsp; @GET  
 &nbsp; public HelloResult sayHello(@QueryParam("name") Optional name) {  
 &nbsp; &nbsp; &nbsp; return new HelloResult(String.format("Hello, %s", name.or("Stranger")));  
 &nbsp; }  
}  
（HelloResource.java）

Dropwizard里用来做RESTFul服务的框架是[Jersey](http://jersey.java.net/)，所以，可以参考Jersey的文档来更好地理解这里的代码。不过，这段代码本身很简单，定义了一个Resource，其中的sayHello是一个GET请求，用来和人打招呼。另外，你看到了这里用到了[Optional](http://dreamhead.blogbus.com/logs/235329092.html)。

HelloResult是一个服务与客户端交互的对象，正如我们服务中所定义的，它会产生一个JSON对象，这个转换是由[Jackson](https://github.com/FasterXML/jackson)完成的。下面是HelloResult类的实现。

public class HelloResult {

&nbsp; &nbsp; private String result;

&nbsp; &nbsp; public HelloResult(String result) {  
 &nbsp; &nbsp; &nbsp; &nbsp;this.result = result;  
 &nbsp; &nbsp;}

&nbsp; &nbsp; public String getResult() {  
 &nbsp; &nbsp; &nbsp; &nbsp;return result;  
 &nbsp; &nbsp;}  
}  
（HelloResult.java）

好了，最基础的东西有了，我们可以把它们连在一起，运行起来。还记得你上次写main函数是什么时候吗？

import com.yammer.dropwizard.Service;  
import com.yammer.dropwizard.config.Bootstrap;  
import com.yammer.dropwizard.config.Configuration;  
import com.yammer.dropwizard.config.Environment;

public class HelloMain extends Service {  
 &nbsp; &nbsp;public static void main(String[] args) throws Exception {  
 &nbsp; &nbsp; &nbsp; &nbsp;new HelloMain().run(args);  
 &nbsp; &nbsp;}

&nbsp; &nbsp; @Override  
 &nbsp; &nbsp;public void initialize(Bootstrap bootstrap) {  
 &nbsp; &nbsp;}

&nbsp; &nbsp; @Override  
 &nbsp; &nbsp;public void run(Configuration configuration, Environment environment) throws Exception {  
 &nbsp; &nbsp; &nbsp; &nbsp;environment.addResource(new HelloResource());  
 &nbsp; &nbsp;}  
}

简单吧？这里我们就继承了一个Service，然后，在run方法里把我们的Resource添加到环境里，最后，在main函数里启动起来。

有了main函数，我们就可以直接把它运行起来，不过，这里是要有参数的：server，指定程序按照server的方式运行。

好了，我们看到程序启动起来了，虽然我们本身什么都没做，实际上，Dropwizard却利用Jetty帮我们把服务加载起来了。剩下的就是打开浏览器，输入

&nbsp; http://localhost:8080/hello

你会看到

&nbsp; {"result":"Hello, Stranger"}

我们几乎没做什么，但JSON已经产生了。它还不认识我们，我们需要一个自我介绍，输入

&nbsp; http://localhost:8080/hello?name=dreamhead

你会看到

&nbsp; {"result":"Hello, dreamhead"}

好，一个最简单的RESTful服务已经开发完毕。如果你是一个传统Java应用的开发者，回想一下，按照原有的工作方式，开发这样一个服务需要怎样的工作量。别的不说，搭建一个Web服务器，配置web.xml，半天就没了，而我们分分钟就可以启动一个服务，这是怎样的效率提升啊！

作为一个Hello的例子，本篇的目标已经达成，就到这里吧！


