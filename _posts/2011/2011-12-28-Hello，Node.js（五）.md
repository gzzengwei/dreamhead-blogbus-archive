---
layout: post
title: Hello，Node.js（五）
author: dreamhead
date: 2011-12-28 21:47:00 +0800
tags: [ 'node.js' ]
categories: [ 'node.js' ]
---

JavaScript是一门已然成为主流的程序设计语言，但无可否认，作为急就章的产物，它还是有很多不令人满意的地方，需要[专门有人告诉我们怎么用它](http://dreamhead.blogbus.com/logs/109407571.html)。

[CoffeeScript](http://coffeescript.org/)边产生于这种背景之下，它就是为了回避JavaScript的丑陋。说穿了，CoffeeScript只是JavaScript的语法糖，所有的CoffeeScript代码最终都会转化成JavaScript代码。

Node.js既然是一个JavaScript的平台，当然也会对CoffeeScript张开怀抱。在Node.js下运行CoffeeScript，首先要安装：  
&nbsp; npm install coffee-script

万事俱备，先来问候吧！

&nbsp; console.log 'hello, coffee'  
&nbsp; (hello.coffee)

然后，运行起来：  
&nbsp; coffee hello.coffee

终端上就会出现  
&nbsp; hello, coffee

之前说过，CoffeeScript代码会转化成JavaScript，我们来看一下由CoffeeScript转化出的JavaScript代码，只要在命令里加入参数即可：  
&nbsp; coffee -c hello.coffee

对应的js文件会产生在当前目录下：  
&nbsp; (function() {  
&nbsp; &nbsp; console.log('hello, coffee');  
&nbsp; }).call(this);  
&nbsp; (hello.js)

包裹在外面的结构让这段代码成为可执行脚本，真正与我们的问候对应的代码实际上是  
&nbsp; console.log('hello, coffee');

当CoffeeScript遇见Node.js，我们就拥有了一个良好的编程平台：不错的运行时环境，加上良好的语言表现力，它们甚至可以让我们忘记了JavaScript的存在。是的，如果初涉Node.js，不妨从CoffeeScript起步。


