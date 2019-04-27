---
layout: post
title: 你应该更新的Java知识之Optional
author: dreamhead
date: 2013-08-21 07:10:00 +0800
tags: [ '你应该更新的Java知识', 'Java', 'Guava', 'Null', 'Optional' ]
categories: [ '你应该更新的Java知识', 'Java', 'Guava', 'Null', 'Optional' ]
---

[你应该更新的Java知识之常用程序库（一）  
](http://dreamhead.blogbus.com/logs/226738702.html)[你应该更新的Java知识之常用程序库（二）  
](http://dreamhead.blogbus.com/logs/226738756.html)[你应该更新的Java知识之构建工具  
](http://dreamhead.blogbus.com/logs/227427912.html)[你应该更新的Java知识之Observer  
](http://dreamhead.blogbus.com/logs/231594181.html)[你应该更新的Java知识之集合初始化  
](http://dreamhead.blogbus.com/logs/232899025.html)[你应该更新的Java知识之集合操作  
](http://dreamhead.blogbus.com/logs/234113759.html)[你应该更新的Java知识之惰性求值](http://dreamhead.blogbus.com/logs/234741366.html)

java.lang.NullPointerException，只要敢自称Java程序员，那对这个异常就再熟悉不过了。为了防止抛出这个异常，我们经常会写出这样的代码：

Person person = people.find("John Smith");  
if (person != null) {  
 &nbsp;person.doSomething();  
}

遗憾的是，在绝大多数Java代码里，我们常常忘记了判断空引用，所以，NullPointerException便也随之而来了。

“Null Sucks.”，这就是Doug Lea对空的评价。作为一个Java程序员，如果你还不知道[Doug Lea](http://g.oswego.edu/)是谁，那赶紧补课，没有他的贡献，我们还只能用着Java最原始的装备处理多线程。

"I call it my billion-dollar mistake."，有资格说这话是空引用的发明者，[Sir C. A. R. Hoare](http://en.wikipedia.org/wiki/Tony_Hoare)。你可以不知道Doug Lea，但你一定要知道这位老人家，否则，你便没资格使用快速排序。

在Java世界里，解决空引用问题常见的一种办法是，使用Null Object模式。这样的话，在“没有什么”的情况下，就返回Null Object，客户端代码就不用判断是否为空了。但是，这种做法也有一些问题。首先，我们肯定要为Null Object编写代码，而且，如果我们想大规模应用这个模式，我们要为几乎每个类编写Null Object。

幸好，我们还有另外一种选择：Optional。Optional是对可以为空的对象进行的封装，它实现起来并不复杂。在某些语言里，比如Scala，Optional实现成了语言的一部分。而对于Java程序员而言，Guava为我们提供了Optional的支持。闲言少叙，先来如何使用Optional，完成前面的那段代码。

Optional person = people.find("John Smith");  
if (person.isPresent()) {  
 &nbsp;person.get().doSomething();  
}

这里如果isPresent()返回false，说明这是个空对象，否则，我们就可以把其中的内容取出来做自己想做的操作了。

如果你期待的是代码量的减少，恐怕这里要让你失望了。单从代码量上来说，Optional甚至比原来的代码还多。但好处在于，你绝对不会忘记判空，因为这里我们得到的不是Person类的对象，而是Optional。

看完了客户端代码，我们再来看看怎样创建一个Optional对象，基本的规则很简单：

如果我们知道自己要封装的对象是一个空对象，可以用  
 &nbsp;Optional.absent();

如果封装的对象是一个非空对象，则可以用  
 &nbsp;Optional.of(obj);

如果不知道对象是否为空，就这样创建创建  
 &nbsp;Optional.fromNullable(obj);

有时候，当一个对象为null的时候，我们并不是简单的忽略，而是给出一个缺省值，比如找不到这个人，任务就交给经理来做。使用Optional可以很容易地做到这一点，以上面的代码为例：

&nbsp; Optional person = people.find("John Smith");  
&nbsp; person.or(manager).doSomething()

说白了，Optinal是给了我们一个更有意义的“空”。


