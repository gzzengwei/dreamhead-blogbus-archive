---
layout: post
title: Hello，Node.js
author: dreamhead
date: 2011-02-17 10:55:00 +0800
tags: [ 'node.js' ]
categories: [ 'node.js' ]
---

 **简介**  
[Node.js](http://nodejs.org/)是什么？它的主页上如是说：  
Evented I/O for V8 JavaScript.   
  
或许[wikipedia上的说法](http://en.wikipedia.org/wiki/Node.js)更容易让人理解：  
Node.js is an event-driven I/O framework for the V8 JavaScript engine on Unix-like platforms. It is intended for writing scalable network programs such as web servers.  
  
简单说来，通过Node.js，我们可以用JavaScript编写Server端应用。显然，这超出我们对JavaScript的常规理解。在传统的印象中，JavaScript是用在浏览器里，用以处理web页面。  
  
**安装**  
下载Node.js，解压缩之后，就是从源码构建Unix应用的常见方式：  
$ ./configure --prefix=$HOME/local/node  
$ make  
$ make install  
$ export PATH=$HOME/local/node/bin:$PATH  
  
更详细的安装文档请参考：  
[https://github.com/ry/node/wiki/Installation](https://github.com/ry/node/wiki/Installation)  
  
**一个例子**    
下面是一个来自Node.js网站的例子，实现了一个简单的echo server。  
var net = require('net');  
net.createServer(function (socket) {  
&nbsp; socket.write("Echo server\r\n");  
&nbsp; socket.on("data", function (data) {  
&nbsp;&nbsp;&nbsp; socket.write(data);  
&nbsp; });  
}).listen(8124, "127.0.0.1");  
  
这个例子展示了Evented I/O的基本处理方式，其实也就是常见的异步处理基本手法，为特定的事件注册一个处理函数。当对应的事件发生时，就会回调这个函数进行处理。  
  
在这个例子里面，我们为socket的data事件注册一个处理（匿名）函数。其实，调用createServer时传进去的函数，也是一个事件处理函数，它处理的是这个server的connection事件。  
  
接下来，就该运行了，把上面的代码保存echo\_server.js里面：  
$ node echo\_server.js  
  
好，server启动了，可以体验一下了，我们可以用telnet进行测试  
$ telnet localhost 8124  
  
随便输入一些什么，我们看到它都会把输入的内容返回给我们。这就是我们用Node.js实现的第一个程序了。


