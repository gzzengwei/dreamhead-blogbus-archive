---
layout: post
title: Hello，Moco（番外篇之前端开发）
author: dreamhead
date: 2013-02-23 12:40:00 +0800
tags: [ 'Moco' ]
categories: [ 'Moco' ]
---

你可以创造一个东西，至于它怎样发展，那就不是你所能预期的了。

Moco里面有这样一个特性，把一个目录下的所有文件挂到一个特定的URI下。其用法如下：

server.mount("dir”, to(”/site”);  
（API）

{  
&nbsp; "mount" :&nbsp; &nbsp; {  
&nbsp; &nbsp; &nbsp; "dir" : "dir",  
&nbsp; &nbsp; &nbsp; "uri" : "/site"  
&nbsp; &nbsp; }  
}  
（JSON）

这么做的初衷是简化一组文件的挂接过程。不过，出人意料的是，有人把这个功能用在了web前端的开发上。

下面是一个简化过的moco配置文件：  
[  
{  
&nbsp; &nbsp; "mount" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "dir" : "site",  
&nbsp; &nbsp; &nbsp; &nbsp; "uri" : "/"  
&nbsp; &nbsp; }  
},  
{  
&nbsp; &nbsp; "request" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "uri" : "/api"  
&nbsp; &nbsp; },  
&nbsp; &nbsp; "response" : {  
&nbsp; &nbsp; &nbsp; &nbsp; "text" : "foo"  
&nbsp; &nbsp; }  
}  
]  
(site.json)

可以看到，我们把site目录挂到了web站点的根目录下，此外，还模拟了一个/api的服务，返回foo。然后，把jquery文件放到site目录下，并在里面写一个index.html：

\<html\>  
\<head\>  
&nbsp; \<script src="jquery-1.9.1.min.js"\>\</script\>  
&nbsp; \<script\>  
&nbsp; $(function() {  
&nbsp; &nbsp; $("button").click(function() {  
&nbsp; &nbsp; &nbsp; $.get("/api", function(data, textStatus) {  
&nbsp; &nbsp; &nbsp; &nbsp; $("p").text(data);  
&nbsp; &nbsp; &nbsp; })  
&nbsp; &nbsp; });  
&nbsp; });  
&nbsp; \</script\>  
\</head\>  
\<body\>  
&nbsp; \<p\>Hello,World\</p\>  
&nbsp; \<button type="button"\>Click\</button\>  
\</body\>  
\</html\>  
（index.html）

从这段html代码我们可以看出，当点击按钮时，它会请求到/api这个uri，然后将请求回来的内容更新上去。正如我们所见到的，实际上，没有一个真正/api服务，只是由moco模拟了一个服务而已。把它运行起来：

&nbsp; java -jar moco-runner--standalone.jar -p 12306 site.json

当我们用浏览器打开这个页面时，点击按钮，我们会看到文字改变了。

通过这个简单的例子，我们便不难理解Moco对于前端开发上的作用了，它启动一个真正的web服务器，使我们正在编写的页面起作用，然后，使用真正的ajax调用去访问后台服务，而Moco会可以将不存在的服务模拟出来。

这么做的好处在于，所有的动态交互部分都是真的。如果在项目前期，开发一个原型验证有效性，做出的包括CSS和JavaScript都是具有真正功能的，在正式开发开始时，可以直接移植到项目里面。这样，也就给了那些不熟悉后端的前端开发人员一个机会，做出具有真正效果的原型。

Moco还能怎么用呢？我们拭目以待。


