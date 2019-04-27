---
layout: post
title: Web Service开发的层次
author: dreamhead
date: 2004-02-05 11:11:00 +0800
tags: [ '向上走' ]
categories: [ '向上走' ]
---

Web Service是最近几年比较火的一个东西，它带来了一大堆的新名词，所以显得比较炫。看透其华而不实的表面，它也就不再神奇。下面的讨论均以Java为参考。

1 访问一个Web Service实际上可以看作调用一个函数，唯一不同的就是这个函数是远程的，这么一说，它和RMI就没有什么本质的区别了。  
&nbsp; 既然是一个函数，当然要有函数的声明了，完成这个工作的就是WSDL，它详细的定义函数的原型，包括函数名、入口参数、出口参数，这就是WSDL中opertion完成的工作。  
&nbsp; 既然是一个远程的函数，还要涉及与远程地址的一个绑定，这是WSDL中service的任务。  
&nbsp; Axis是一个可以通过WSDL生成相应访问代码的开发包，JBuilder中将它集成了进去，通过Wizard的方式简化了原本需要在命令行中手工完成的操作。

2 既然是远程访问，就一定要有一个访问协议，Web Service的访问协议就是SOAP，SOAP建立在XML之上，不同的就是对XML原本没有限制的格式加上了一些限制，需要有envelope，在envelope中，还要分header和body。  
&nbsp; 如果利用SOAP开发Web Service的程序，那就需要根据WSDL的定义来自行组装SOAP包，这显然要比利用WSDL直接面向Web Service开发要复杂一些。  
&nbsp; JAXM是一个利用SOAP进行通信的开发包，它简化了SOAP消息的打包过程。

3 SOAP是建立在XML之上的，那么显然XML的开发包同样适合于SOAP。  
&nbsp; 在这个层次上开发Web Service，除了要完成上一层的工作外，还要自行按照SOAP的格式组装SOAP消息，这显然又增加了工作量。  
&nbsp; XML的开发工具就比较多了，从最简单的SAX和DOM到DOM4J、JDOM，还有不少XML到对象绑定的工具，如JAXB、Castor等等。  
&nbsp; 其实，不考虑Web Service，完全用XML做通信协议的情况也并不少见。知晓XML-RPC的存在，就不难理解了XML做通信的含义了。

截至到这里所讨论的内容，Sun提供了JWSDP（Java Web Service Developer Pack），其中包含从XML解析到WSDL生成的全套解决方案。

4 上面讨论的所有东西实际上都还停留在传递消息的内容上，并未涉及通信的过程。不要一看到Web Service的Web就想当然认为它只能通过HTTP来传输。前面的讨论可以看出，所有的消息内容与传输并无直接关系，所以，无论是以HTTP传输，还是SMTP或是自定义的协议都没有问题。  
&nbsp; 在这个层次上开发Web Service，前面的种种险阻之外，还要完成对XML的手工解析工作。  
&nbsp; 这里还是以最常见的HTTP方式来讨论。&nbsp;   
&nbsp; HTTP的开发就将Server和Client区别对待，Server的实现通常的选择是Servlet，让Web Server替我们完成HTTP协议的解析可以省去我们很多的作。Client的实现可以选择JDK自带的Http Client，Apache的Jakarta项目下的Commons子项目也提供了一个HttpClient。

5 无论是HTTP还是SMTP，抑或是自定义协议，归根结底都是应用级的协议，底层的实现都是由Socket完成。到了这个层次基本就是原始时代了，什么都没有，一切都要手工完成。  
&nbsp; 在这个层次上开发Web Service，所有前面的困难都要一一经历，此外，还有协议的开发等待着不幸至此的人们。  
&nbsp; 到了这里，也不需要其它的工具了，JDK自带的Socket可以保打天下。

6 还想往下吗？再往下就是操作系统的实现了，Java的平台无关就失去了意义，也超出了我目前所了解的范围，到此打住吧！

前面所提及应该算是Web Service的一个基本知识结构，这里并没有讨论UDDI等等的内容，一来我对它并不了解，二来那应该属于应用，不应该算Web Service实现中。

虽然我们可能不会从最下层开发Web Service，但遇到底层的问题的情况却在所难免。  
我就曾经在开发一个Web Service应用的时候，被人抓住HTTP头中的SOAPAction大小写与某个所谓的规范不同，我查了半天HTTP规范和SOAP规范，知道了HTTP是区分大小，而SOAPAction就是应该这么写，据理力争，指出所谓规范的错误。

经过前面的讨论，我们可以看出，Web Service并没有什么神秘可言，所有的东西都是建立在已有东西的基础之上。技术的发展不会是无中生有，只会是一个更好的解决方案而已，在追新求变之前，一个比较牢固的基础才是最重要的。


