---
layout: post
title: 用Annotation标记Ruby方法
author: dreamhead
date: 2007-07-30 20:45:00 +0800
tags: [ '向下走' ]
categories: [ '向下走' ]
---

JRuby最近在讨论是否要支持Java 5。  
  
JRuby邮件列表的讨论  
[http://www.nabble.com/Moving-to-Java-5--tf4131923.html](http://www.nabble.com/Moving-to-Java-5--tf4131923.html)  
  
InfoQ报道  
[http://www.infoq.com/news/2007/07/jruby-java5-move](http://www.infoq.com/news/2007/07/jruby-java5-move)  
[http://www.infoq.com/cn/news/2007/07/jruby-java5-move](http://www.infoq.com/cn/news/2007/07/jruby-java5-move)  
  
XRuby起步就是从Java 5开始的，所以，不存在这个问题。在他们还在为此争论的时候，受到Charles Nutter最开始那封邮件的启发，我已经完成了Annotation标记Java代码和Ruby代码绑定的第一个版本。  
  
下面是一个例子：  
@RubyLevelClass(name="ClassFactory")  
public class ClassFactoryValue extends RubyValue {  
&nbsp;&nbsp;&nbsp; ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;  
&nbsp;&nbsp;&nbsp; @RubyLevelMethod(name="test", type=MethodType.NO\_ARG)  
&nbsp;&nbsp;&nbsp; public RubyValue test() {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RubyConstant.QNIL;  
&nbsp;&nbsp;&nbsp; }  
}  
  
首先，用@RubyLevelClass标记出这个Java类对应着一个Ruby层次上的类，其名称为ClassFactory。然后，用@RubyLevelMethod标记出一个Java方法是对应着Ruby的方法，它的Ruby名称为test，而且它是无参数的。  
  
我们可以这样利用这段代码：  
RubyClass klass = RubyTypeFactory.getClass(ClassFactoryValue.class);  
  
通过RubyTypeFactory，我们可以生成ClassFactoryValue将Java层次和Ruby层次对应起来的代码，生成代码大致如下：  
public class ClassFactoryValue$ClassBuilder implements RubyClassBuilder {  
&nbsp;&nbsp;&nbsp; public RubyClass createRubyClass() {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RubyClass rubyclass = RubyAPI.defineClass("ClassFactory", RubyRuntime.ObjectClass);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MethodFactory methodfactory = MethodFactory.createMethodFactory(ClassFactoryValue.class);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rubyclass.defineMethod("test", methodfactory.getMethod("test", MethodType.NO\_ARG));  
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rubyclass;  
&nbsp;&nbsp;&nbsp; }  
}  
  
这里用之前介绍过的[生成方法Wrapper的MethodFactory](http://dreamhead.blogbus.com/logs/6520681.html)去辅助代码生成，简化了编写。  
  
XRuby本身为了生成bytecode已经做了大量的代码生成，这里只是把代码生成更多的用在了其他的部分。把这里的Annotation更广泛的用在XRuby中，会让代码看上去更干净。


