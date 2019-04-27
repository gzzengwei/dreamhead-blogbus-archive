---
layout: post
title: Hello，Vagrant
author: dreamhead
date: 2012-09-18 17:52:00 +0800
tags: [ 'hello', 'vagrant' ]
categories: [ 'hello', 'vagrant' ]
---

在这个虚拟化当道的年代，作为一个程序员，你一定对[VirtualBox](https://www.virtualbox.org/)不会陌生，是的，它就是个虚拟机。不过，这里要说的却是[Vagrant](http://vagrantup.com/)，那Vagrant又是什么呢？

如果说VirtualBox是个芸芸众生的虚拟机，那Vagrant就是程序员的VirtualBox。你要知道，作为一个程序员，我们认为，什么东西都应该在命令行下控制。当然，对于程序员这个群体，要是面对一个可以在命令行下控制的虚拟机，我们要的可绝不是“打开虚拟机、上个网银”。

Vagrant是用Ruby写的，所以，安装之前，确保你装好了Ruby和RubyGems。一般来说，我会用[RVM](https://rvm.io/)安装Ruby这套东西，仅供参考。再有既然是要控制VirtualBox，安装一个VirtualBox也是必然的。

准备好基本的东西，安装Vagrant就非常简单了：

&nbsp; gem install vagrant

接下来，就该是使用了。不过，在此之前，我们先要找一个虚拟机镜像来，就像使用一般的机器先要装机一样。此外，我们还要让vagrant知道这个镜像文件的存在，下面就是这样一个命令：

&nbsp; vagrant box add base http://files.vagrantup.com/lucid32.box

在vagrant里，这个概念叫做box，所以，这个命令的意思，我要添加一个box，我给它命名成base，它的地址是http://files.vagrantup.com/lucid32.box。

其实，这个如果你熟悉Ubuntu的命名规则，便不难发现，这个box是一个Ubuntu的镜像。事实上，这个box显然不是唯一的选择，如果我们想要其它版本的操作系统，我们的选择还有很多，在这里可以找到：

&nbsp; [http://www.vagrantbox.es/](http://www.vagrantbox.es/)

剩下的就是，选择我们想要的操作系统，给它命个名字，就可以用起来了。

找一个目录进去，是的，最好这么做，因为接下来，我们会生成文件，放在一个特定的路径里，不容易丢掉：

&nbsp; vagrant init base

从命令行的提示里，我们可以看到，vagrant为我们创建了一个Vagrantfile，里面有好多内容，不过，把细致查看留给你，让我们先体会一下成就感吧！启动我们的虚拟机。

&nbsp; vagrant up

一切正常的话，在打出一片提示之后，我们的虚拟机就运行起来了。怎么才能用上这个新“机器”呢？其实，这就是一台独立的机器，我们可以ssh上去。

&nbsp; vagrant ssh

好了，尽情折腾吧，这是我们程序员的虚拟机。


