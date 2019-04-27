---
layout: post
title: Hello，Node.js（三）
author: dreamhead
date: 2011-02-24 15:47:00 +0800
tags: [ 'node.js' ]
categories: [ 'node.js' ]
---

初涉Node.js，require引起了我的注意。  
  
编写JavaScript代码时，我特别想做的事就是把公共代码提取出来放到一个单独文件里。无情的现实告诉我，对于这种大路货般的需求，JavaScript的支持并不好。我们不能在一个文件中声明（无论是import、include还是require），只能在每个需要的页面进行声明。这种做法并不符合我对程序设计语言的审美。  
  
看到require时，我知道一些不同的东西出现了。它给JavaScript提供了一种module机制，通过它，我们可以把代码分散到不同文件里了，告别一棵树上吊死的尴尬。  
  
下面是一个简单的例子。我们有一个module，放在hello.js里。  
exports.hello = function(name) {  
&nbsp;&nbsp;&nbsp; return "hello " + name;  
}  
(hello.js)  
  
在同样的目录，我们还有一个main.js，其中调用了hello.js定义的函数。  
var module = require('./hello');  
console.log(module.hello('dreamhead'));  
(main.js)  
  
接下来，就是执行代码，我们会看到给予我们的问候。  
$ node main.js  
hello dreamhead  
  
实际上，module能力并不是Node.js带来的，而是源自[CommonJS](http://www.commonjs.org/)。Module只是CommonJS的一部分。  
  
就CommonJS而言，它有一个更为宏大的目标。官方的JavaScript标准只为构建基于浏览器的应用提供了一些基础的API。随着JavaScript的发展，浏览器已无法阻挡JavaScript，越来越多的JavaScript应用超出了浏览器的范畴。这时JavaScript自身的一些限制成为了障碍。于是，有人提出为JavaScript定义一些构建通用应用所需的API，这种努力的结果就是CommonJS。

CommonJS定义了许多[规范](http://www.commonjs.org/specs/)，module就是其中之一，此外，还有诸如一些标准库，比如，console、文件系统等等，还有包机制等等。CommonJS有很多不同的[实现](http://www.commonjs.org/impl/)，Node.js就是实现之一。

正是CommonJS的存在，Node.js得以变身为一个编程平台。


