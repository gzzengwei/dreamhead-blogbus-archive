---
layout: post
title: Hello，Node.js（二）
author: dreamhead
date: 2011-02-21 10:48:00 +0800
tags: [ 'node.js' ]
categories: [ 'node.js' ]
---

从[上一篇的介绍](http://dreamhead.blogbus.com/logs/105599686.html)里面，我们知道了Node.js可以用来编写Server端应用。但实际上，Node.js带来的可不这些，其实，我们可以把它视为一个独立的编程平台，通过它，我们可以像使用Ruby、Python一样使用JavaScript。  
  
所以，学习Node.js和学习其它编程平台可以等同起来，事实上，人们也是这样来对待Node.js的。比如，在Ruby中，我们通过RubyGems管理各种软件包进行管理，而在Node.js中，与之对应的是[npm](http://npmjs.org/)。  
  
安装npm，非常简单，只要执行下面的命令即可。  
$ curl http://npmjs.org/install.sh | sh  
  
有了npm，我们就可以利用它安装软件包了，欲知有哪些软件包可以安装，npm为我们提供了[一个可以搜寻的地方](http://search.npmjs.org/)。  
  
如果你熟悉常见的包管理器，用npm安装软件包和它们如出一辙。以Express为例：  
$ npm install express  
  
[Express](http://expressjs.com/)是一个web开发框架，不过，它并不是[Rails](http://rubyonrails.org/)那样的全功能框架，而更多的把精力集中在web层，如果你熟悉Ruby世界的开发框架，它更像[Sinatra](http://www.sinatrarb.com/)。  
  
下面就是Express版的“hello, world”：  
var app = require('express').createServer();  
  
app.get('/', function(req, res){  
&nbsp;&nbsp;&nbsp; res.send('hello world');  
});  
  
app.listen(3000);  
  
把它保存在hello\_express.js中，我们就可以运行它了：  
$ node hello\_express.js  
  
好，打开浏览器，访问http://localhost:3000/，我们就可以看到来自express的问候了。


