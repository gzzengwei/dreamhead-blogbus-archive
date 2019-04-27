---
layout: post
title: Hello，Akka
author: dreamhead
date: 2013-09-11 07:24:00 +0800
tags: [ 'akka' ]
categories: [ 'akka' ]
---

只要稍微了解过一些[Scala](http://scala-lang.org/)，这门JVM上广受关注的程序设计语言，你一定会对其中的一个Actor特性印象深刻。[Actor](http://en.wikipedia.org/wiki/Actor_model)是另一种进行并发计算的方式。通过在不同的Actor之间彼此发送消息，我们会惊喜地发现，那令人纠结的锁将不再困扰我们。

不过，那是Scala的世界，作为一个Java程序员难道只有艳羡的份吗？显然不是。[Akka](http://akka.io/)把Actor带到了Java世界。

实际上，Akka主要是以Scala编写的，但它很好地支持Java API，让所有特性对于Java程序员也唾手可得。即使相比于与Scala内建的Actor，Akka也不遑多让。Akka除了最基本的Actor特性外，它可以能在多台机器上透明地实现Actor，此外，还提供了很好的监管特性，这些都是Scala内建的Actor所不具备的。

说了那么多，让我们用一个Hello的例子和Akka打个招呼吧！

既然我们这里关注的是Actor，我们就来实现两个Actor，让它们之间实现问候。下面是一个：

import akka.actor.Props;  
import akka.actor.UntypedActor;  
import akka.actor.ActorRef;

public class HelloWorld extends UntypedActor {

&nbsp; &nbsp; @Override  
 &nbsp; &nbsp;public void preStart() {  
 &nbsp; &nbsp; &nbsp; &nbsp;final ActorRef greeter =  
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;getContext().actorOf(Props.create(Greeter.class), "greeter");  
 &nbsp; &nbsp; &nbsp; &nbsp;greeter.tell(Greeter.Msg.GREET, getSelf());  
 &nbsp; &nbsp;}

&nbsp; &nbsp; @Override  
 &nbsp; &nbsp;public void onReceive(Object msg) {  
 &nbsp; &nbsp; &nbsp; &nbsp;if (msg == Greeter.Msg.DONE) {  
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;getContext().stop(getSelf());  
 &nbsp; &nbsp; &nbsp; &nbsp;} else {  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unhandled(msg);  
&nbsp; &nbsp; &nbsp; &nbsp;}  
 &nbsp; }  
}  
（HelloWorld.java）

这个HelloWorld继承了UntypedActor，表明我们实现的是一个Actor。

其中的preStart是在启动这个Actor时调用的方法。在这里，我们创建了另一个Actor的实例。我们稍后会看到另一个Actor Greeter的实现。然后，我们调用tell方法给它发了一个消息，Greeter.Msg.GREET，后面的getSelf()给出了一个Actor的引用（ActorRef），用以表示发消息的Actor。这只是启动一个Actor，后面的部分才是更重要的。

onReceive方法是处理我们接收到消息的情况。这里我们看到，如果接收到的消息是一个Greeter.Msg.DONE，我们就会停下（stop）所有的处理，同样，getSelf()指明停下的目标，否则的话，就说我们没处理（unhandled）。

看完了一个Actor，或许你已经迫不及待地想看与它打交道的另一个Actor了，下面就是：

import akka.actor.UntypedActor;

public class Greeter extends UntypedActor {

&nbsp; &nbsp; public static enum Msg {  
 &nbsp; &nbsp; &nbsp; &nbsp;GREET, DONE  
 &nbsp; &nbsp;}

&nbsp; &nbsp; @Override  
 &nbsp; &nbsp;public void onReceive(Object msg) {  
 &nbsp; &nbsp; &nbsp; &nbsp;if (msg == Msg.GREET) {  
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;System.out.println("Hello World!");  
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;getSender().tell(Msg.DONE, getSelf());  
 &nbsp; &nbsp; &nbsp; &nbsp;} else {  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unhandled(msg);  
&nbsp; &nbsp; &nbsp; &nbsp;}  
 &nbsp; &nbsp;}  
}  
（Greeter.java）

同样的Actor结构，我们已经在HelloWorld类里面看到了。在onReceive方法里，如果它接收到的消息是Msg.GREET，它就打印出“Hello World!”，然后，给发送者回复一条Msg.DONE。没处理的话，就说没处理。

就是这么简单！

好，万事具备，我们把它跑起来。你看到了我们还没有入口点，实际上，Akka自身为我们提供了一个。设置好classpath之后，我们只要这样运行即可：

&nbsp; &nbsp; java akka.Main HelloWorld

这里的akka.Main就是我们的入口点，我们把HelloWorld这个类名传给它作为启动参数。运行的结果自然是我们最熟悉的：

&nbsp; &nbsp; Hello World!

好，就到这里吧！


