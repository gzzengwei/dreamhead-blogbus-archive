---
layout: post
title: 一个用C++实现的Dispatcher（三）
author: dreamhead
date: 2010-09-13 23:15:00 +0800
tags: [ '向上走', '咨询' ]
categories: [ '向上走', '咨询' ]
---

[eBen](http://ebenzhang.blogbus.com/)给《[一个用C++实现的Dispatcher（二）](http://dreamhead.blogbus.com/logs/74698689.html)》提出了一些非常好的问题，修正了一些细节。但有一点需要稍加讨论一下：  
那几个new,可能某些做服务器端程序的人会受不了. handlers倒是可以做成static的.所有对象共用一份就可以了.   
  
这个问题在实现这个dispatcher的时候，有人提出来过，但我依然坚持我的选择。  
  
似乎做过服务器应用的人对性能和内存都有着特别的敏感，我也做过，我也一样。如果每个请求都去创建dispatcher的话，不仅是内存，还有创建的成本在里面。  
  
但是，我们为什么要每次都去创建呢？如果一次创建好，就存放在内存中，不就没有这样的问题了。  
  
把handlers设计成static，不是一个好的设计，这样的话，这个dispatcher类本身就是有状态的了，一个对象的误操作很容易就影响到另外的对象。一个好的设计应该是尽可能无状态的，这也是全局变量不受欢迎的一个原因，杀伤力太大，且错误不好定位。  
  
之所以有人曾经给我提出过这个问题，因为他们的代码里有太多这样的代码：  
void Main::run() {  
&nbsp;&nbsp;&nbsp; ...  
&nbsp;&nbsp;&nbsp; MsgDispatcher dispatcher;  
&nbsp;&nbsp;&nbsp; dispatcher.dispatch(&msg);  
&nbsp;&nbsp;&nbsp; ...  
}  
  
这样的用法去使用这个dispatcher当然会有他们所担心的问题。解决起来很容易，把这个局部变量提取出来，比如做成类成员。  
  
我们现在知道了正确的做法是只初始化一次。不过，如果这是一个内层的代码就稍微麻烦一些了，即便这个类修正好了，我们不能保证这个代码在外层只调用了一次。面对遗留代码时，事往往不如意。  
  
在这种情况下，我会为这个dispatcher实现一个singleton：  
class MsgDispatcherSingleton {  
public:  
&nbsp;&nbsp;&nbsp; static MsgDispatcher\* getDispatcher() {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (NULL == dispatcher) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dispatcher = new MsgDispatcher;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; …  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }  
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dispatcher;  
&nbsp;&nbsp;&nbsp; }  
private:  
&nbsp;&nbsp;&nbsp; MsgDispatcherSingleton() {}  
  
&nbsp;&nbsp;&nbsp; static MsgDispatcher\* dispatcher;  
}  
  
MsgDispatcher\* MsgDispatcherSingleton::dispatcher = NULL;  
  
需要知道的是，这是为了遗留代码所做的妥协，并不是我们真正设计的一部分。所以，我把它独立出来，如果有一天遗留代码被消除了，这个类也该随风而去。


