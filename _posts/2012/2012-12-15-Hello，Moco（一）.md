---
layout: post
title: Hello，Moco（一）
author: dreamhead
date: 2012-12-15 13:31:00 +0800
tags: [ 'Moco', '测试', 'HTTP' ]
categories: [ 'Moco', '测试', 'HTTP' ]
---

[Moco](https://github.com/dreamhead/moco)是一个用以简化测试服务器搭建的框架，主要做测试和集成之用。

**起因**

所谓企业级开发，多半都意味着有一大堆系统要集成，时至今日，最为流行的集成方式莫过于通过Http协议，无论是Web Service，抑或是REST架构。在我的开发记忆里，有人会安装一个web server，然后放进去一些静态文件，稍微复杂的点，自己写一个Java应用，部署起来，做所谓的动态响应，更有甚者，我要搭建一个Web容器，比如Tomcat。总而言之，麻烦。

简单是一个好的开发人员永远应该追求的，再经历了无数次集成的痛苦之后，Moco向简化这种繁琐集成迈出了一步。闲话少叙，上例子。

**用法**

Moco目前有两种使用方式，一种是API，一种是独立运行。

下面是一个API的例子，其实这就是一个普通的JUnit测试：

@Test  
public void should\_response\_as\_expected() {  
&nbsp; MocoHttpServer server = httpserver(8080);  
&nbsp; server.reponse("foo");

&nbsp; running(server, new Runnable() {  
&nbsp; &nbsp; @Override  
&nbsp; &nbsp; public void run() {  
&nbsp; &nbsp; &nbsp; try {  
&nbsp; &nbsp; &nbsp; &nbsp; Content content = Request.Get("http://localhost:8080").execute().returnContent();  
&nbsp; &nbsp; &nbsp; &nbsp; assertThat(content.asString(), is("foo"));  
&nbsp; &nbsp; &nbsp; } catch (IOException e) {  
&nbsp; &nbsp; &nbsp; &nbsp; throw new RuntimeException(e);  
&nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; }  
&nbsp; }  
}

这里我们搭建了一个http服务器，端口是8080。我们期望访问的时候，它能够返回foo。然后，调用running方法，我们就有了一个环境，启动了一个真正的服务器。这个例子里，我们用了[Apache的Http Client Fluent API](http://hc.apache.org/httpcomponents-client-ga/tutorial/html/fluent.html)去访问这个本地启动的服务器。如你所见，当我们访问时，它会给我们返回字符串“foo”。也许你已经想到了，如果我们设置的这个字符串如果是一个SOAP形式，它就模拟了一个Web Service。

嗯，就是这么简单！

有时候，我们不仅仅是想在测试里用它，而是希望搭建一个独立的测试服务器。这就是Moco另一种形式发挥作用的时候，只要我们给它提供一个配置文件，声明我们所需服务的样子。目前Moco支持配置文件的格式是JSON。下面是一个例子：

{  
&nbsp; "port" : 8080,  
&nbsp; "sessions" :  
&nbsp; &nbsp; [  
&nbsp; &nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; &nbsp; "response" :  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; ]  
}  
（foo.json）

这个例子同之前一样，当我们访问服务器时，我们期待返回的是一个字符串“foo”。这个配置同之前的API如出一辙，就不多做解释了。我们把它运行起来：

&nbsp; java -jar moco-runner--standalone.jar foo.json

打开你的浏览器，输入http://localhost:8080/，“foo”就呈现在你面前了。

嗯，就是这么简单！

当然，Moco能做的远不止这些，接下来，我们会飞快地浏览Moco的功能，请系好安全带，我们开始了。


