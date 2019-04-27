---
layout: post
title: Hello，Moco（二）
author: dreamhead
date: 2012-12-16 13:41:00 +0800
tags: [ 'Moco', '测试', 'HTTP' ]
categories: [ 'Moco', '测试', 'HTTP' ]
---

如你所见，Moco主要是通过配置模拟服务器端的行为。目前主要支持两种配置：请求（Request）和应答（Response）。简而言之，当请求是什么样时，返回怎样的应答。前面你已经见过最简单的例子了，不管请求什么都返回“foo”作为应答。

**请求（Request）**

- 内容

有时，我们希望根据请求的内容返回相应的应答，我们可以这样配置：

server.request(by("foo")).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

如果请求内容过大，我们还可以把它放到文件里：

server.request(by(file("foo.request"))).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "file" : "foo.request"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

- URI

有时，我们主要关注URI，那我们可以这样配置：

server.request(by(uri("/foo"))).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "uri" : "/foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

URI常常与某些参数相伴，可以针对不同参数配置不同的返回：

server.request(and(by(uri("/foo")), eq(query("param"), "blah"))).response("bar")  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "uri" : "/foo"  
&nbsp; &nbsp; &nbsp; "queries" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "param" : "blah"  
&nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

- HTTP

REST让人们重新认识了HTTP动词的价值，Moco当然也不会错过：

server.get(by(uri("/foo"))).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "method" : "get",  
&nbsp; &nbsp; &nbsp; "uri" : "/foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

这里是get，当然post也是很常见的：

server.post(by("foo")).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "method" : "post",  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

除了HTTP动词，另一个越来越受关注的是HTTP头：

server.request(eq(header("foo"), "bar")).response("blah")  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "method" : "post",  
&nbsp; &nbsp; &nbsp; "headers" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "content-type" : "application/json"  
&nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

- XPath

Web Service的火爆让XML大行其道，根据XML内容进行判断的一种方式就是XPath：

server.request(eq(xpath("/request/parameters/id/text()"), "1")).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "method" : "post",  
&nbsp; &nbsp; &nbsp; "xpaths" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "/request/parameters/id/text()" : "1"  
&nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

**应答（Response）**

- 内容

最先想到的一定是返回特定的内容，其实之前已经看到了：

server.request(by("foo")).response("bar");  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "bar"  
&nbsp; &nbsp; }  
}  
（JSON）

同请求一样，如果内容很多，就放到文件里：

server.request(by("foo")).response(file("bar.response"));  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "file" : "bar.response"  
&nbsp; &nbsp; }  
}  
（JSON）

&nbsp;

&nbsp;

- HTTP

&nbsp;

Moco支持应答中的HTTP状态码：

server.request(by("foo")).response(status(200));  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "status" : 200  
&nbsp; &nbsp; }  
}  
（JSON）

我们还可以指定HTTP应答Header里的内容：

server.request(by("foo")).response(header("content-type", "application/json"));  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "headers" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "content-type" : "application/json"  
&nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; }  
}  
（JSON）

&nbsp;

- URL

有时，我们也可以请求转发到另外一个网站上，换句话说，Moco这时扮演了一个代理的角色：

server.request(by("foo")).response(url("http://www.github.com"));  
（API）

{  
&nbsp; "request" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; },  
&nbsp; "response" :  
&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "url" : "http://www.github.com"  
&nbsp; &nbsp; }  
}  
（JSON）

- 顺序应答

有时，我们希望模拟一个改变服务器端资源的真实操作，比如：

1. 当我们发起第一个get请求时，服务器返回“foo”。
2. 然后，我们发起了一个post请求，改变了服务器端资源。
3. 当我们再发起请求时，我们希望服务器返回“bar”。

Moco支持我们对同一个请求返回不同的值：

server.request(by(uri("/foo"))).response(seq("foo", "bar", "blah"));  
（API）

如你所见，第一次请求会返回foo，第二次会返回“bar”，第三次则是“blah”。

以上就对Moco的基本功能做了一个快速浏览。嗯，就是这么简单！

如果你在项目里经常遇到各种各样的集成需求，尤其是HTTP方式的集成，不妨试试Moco，希望它可以让你的开发更简单一些。当然，作为一个年轻的项目，Moco欢迎各种各样的想法。


