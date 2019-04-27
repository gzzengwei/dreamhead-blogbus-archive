---
layout: post
title: 在成都Open Party讲Moco
author: dreamhead
date: 2013-02-25 07:34:00 +0800
tags: [ 'Moco', 'OpenParty' ]
categories: [ 'Moco', 'OpenParty' ]
---

[时隔一年](http://dreamhead.blogbus.com/logs/192363088.html)，我又参加了成都的Open Party。这次参加Open Party，我带的主题是Moco。

Moco最近发展得不错。多谢[gigix](http://gigix.thoughtworkers.org/)，已经有第一个实际的商业项目开始使用Moco，他不断给我提出新的需求，最近一段时间，我每天忙不停地给Moco写新代码。我也越来越觉得，Moco开始告别我一个人的自娱自乐阶段，应该与更多人分享。于是，我决定在社区活动里做一次Moco的分享。

分享总是有益的，当你把自己的东西抛出去，就会有人把他的想法抛给你。这不，有人给Moco提出了新特性。

一个特性是延迟，也就是让服务器等待一段时间返回，用以模拟服务器的慢速操作。这是第二次有人给我提出这个想法，我认为这个需求真的是有必要了。鉴于这个特性实现了起来很简单，我已经完成了编程工作，提交到代码库里了。

另一个特性是支持Socket。现在Moco只支持HTTP，因为在我目前的工作里，这是优先级最高的。在这次活动之后，分别有两个人与我交流时都提到了Socket模拟的想法。在一些游戏项目里，对于性能的要求很高，Socket是一个比HTTP更好的选择。我已经把Socket列到了我的TODO列表里，只是目前而言，我还需要更多的需求以确定Socket模拟该如何表现。

在分享之后，有人问了一些有趣的问题。

有人关心Moco启动飞快的原因，底层用了哪个库。目前Moco底层用的[Netty](http://netty.io/)，JBoss的一个异步IO库，类似的库还有[grizzly](http://grizzly.java.net/)和[Mina](http://mina.apache.org/)。虽然Moco支持的HTTP，但我并没有选择Tomcat或Jetty，从Moco提供的接口可以看到，我实在是不需要Sevlet那层抽象。也是因为省去了一层抽象的原因，启动速度自然就是飞快了。Netty本身是一个更底层的库，未来支持Socket的话，也可以拿来就用。

有人问是不是ThoughtWorks是不是给我专门的时间写开源项目。上班时间肯定主要是给客户写代码，那我的时间从何而来。关于这个问题，最好的回答是之前的一篇blog《[聊聊早起](http://dreamhead.blogbus.com/logs/225006531.html)》。现在每天在5点半左右起床，上班之前大约会有一个半到两个小时做一些自己要做的事情。每天坚持下来，就会是一笔很好的时间财富。我现在基本上也是把这个做法作为一种最佳实践推荐给身边的许多人，我知道，已经有人开始从中受益了。

把自己的东西拿出来，别人会回馈给我们更多，这就是社区分享的好处。


