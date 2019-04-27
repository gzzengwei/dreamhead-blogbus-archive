---
layout: post
title: Hello，Node.js（四）
author: dreamhead
date: 2011-12-08 21:18:00 +0800
tags: [ 'node.js' ]
categories: [ 'node.js' ]
---

[Hello，Node.js](http://dreamhead.blogbus.com/logs/105599686.html)  
[Hello，Node.js（二）](http://dreamhead.blogbus.com/logs/106188588.html)  
[Hello，Node.js（三）](http://dreamhead.blogbus.com/logs/106592931.html)

**版本管理器**

Node.js的发展速度是令人吃惊的，不长时间就会有一个新版本推出。每次追着升级新版本是一件让人不爽的事情，尤其是每次都去手工编译安装。

Ruby世界的人们不满意Ruby混乱的版本管理，于是有了[RVM](http://beginrescueend.com/)，同样，Node.js世界有了[NVM](https://github.com/creationix/nvm)。顺便说一下，在程序员的世界里，VM除了代表Virtual Machine，也代表Version Manager。

**安装NVM**

首先，我们需要得到nvm：

&nbsp; git clone git://github.com/creationix/nvm.git ~/.nvm

执行成功之后，我们得到了nvm，为了让nvm起作用，我们可以执行：

&nbsp; . ~/.nvm/nvm.sh

但是，这种做法只能在当前的shell会话中起作用，为了长治久安，一种更好的办法是把它加入到shell的配置文件中，根据不同的环境，它可能是~/.profile，~/.bashrc等等。我们把下面这句加入其中：

&nbsp; [[-s "$HOME/.nvm/nvm.sh"]] && . "$HOME/.nvm/nvm.sh"

这样，启动一个新shell会话，我们就可以直接使用nvm了。

好了，环境就绪，我们可以使用它了。

**NVM基本用法**

我们可以了解一下nvm的基本用法：

&nbsp; nvm help

安装一个新版本的Node.js：

&nbsp; nvm install v0.6.4

注意，这里的版本号里有个v，而在别的命令里，并不需要这个v。

这个命令简化了Node.js的安装过程，它会在Node.js的发布库中找到对应的版本下载，然后进行安装。安装node.js的同时，nvm也会把npm替我们安装好，这样，我们就具备一个开发最为基本的环境。

使用一个安装好的版本：

&nbsp; nvm use 0.6.4

用一个特定版本运行程序：

&nbsp; nvm run 0.6.4 echo\_server.js


