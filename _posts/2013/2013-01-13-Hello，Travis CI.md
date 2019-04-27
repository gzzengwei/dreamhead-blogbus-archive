---
layout: post
title: Hello，Travis CI
author: dreamhead
date: 2013-01-13 08:36:00 +0800
tags: [ 'travis-ci', 'github', 'gradle' ]
categories: [ 'travis-ci', 'github', 'gradle' ]
---

Travis CI，是一个专门为开源项目打造的持续集成环境。

如果你有一个放在github上的开源项目，Travis CI简直就是一个完美的CI选择。下面以[Moco](https://github.com/dreamhead/moco)为例，说明如何在自己的项目里添加Travis CI支持。

实际上，只要采用的是“标准工具”，支持Travis CI就简单得一塌糊涂。第一步，我们要在自己项目的根目录下添加一个文件.travis.yml。

language: java  
jdk:  
&nbsp; - oraclejdk7  
&nbsp; - openjdk7  
&nbsp; - openjdk6  
（.travis.yml）

很容易理解，首先，我们告诉Travis CI，我们的语言是什么。这样，它会根据你的语言为你选择构建工具。对于Moco而言，构建工具是[gradle](http://www.gradle.org/)，这是Java世界的新标准了，Travis CI会自动识别出来，我不需要额外告诉它什么。当然，它为Java项目支持的另外两个选择是[Maven](http://maven.apache.org/)和[Ant](http://ant.apache.org/)。如果你的项目是不同的语言，可以参考[Travis CI的文档](http://about.travis-ci.org/docs/user/getting-started/)，找到适合自己的配置。

接下里的JDK是要告诉Travis CI，我要在哪些环境下测试。比如这里用了三个JDK，分别是Oracle JDK 7、OpenJDK 7和OpenJDK 6。这样一来，当我们提交代码时，Travis CI会在三个不同环境运行我们的测试，以此保证项目的版本兼容。

此外，还要额外说一下，它是如何选择运行目标的。对于Moco这样提供了Gradle支持的项目，Travis CI缺省情况下会执行gradle check，这是Gradle进行检查的缺省做法，它会编译源文件、处理资源文件、运行测试等等。在运行这个任务之前，Travis CI还会运行gradle assemble用以安装项目中用到的依赖。所有这些都是可以修改的，可以参考了Travis CI的[构建配置文档](http://about.travis-ci.org/docs/user/build-configuration/)。

有了这个脚本还不够，我们还要让Travis CI知道我们的项目，用自己的github账号登录Travis CI。经过认证之后，选择自己的账号配置，你会看到自己的所有的开源项目都列在那里。如果没有看到项目，请自行同步（Sync Now）。剩下的就很简单了，把要支持的Travis CI项目从OFF状态拨成ON。实际上，Travis CI是给github设置一个钩子。当有代码提交上来的时候，它会告诉Travis CI，Travis CI就可以开始构建了。

好，设置完毕，尝试提交代码吧！当代码提交到github上之后，你应该可以看到你的项目开始构建了。哦，对了，项目的Travis CI地址应该等同于github上项目的地址，比如，Moco的github地址是

&nbsp; [https://github.com/dreamhead/moco](https://github.com/dreamhead/moco)

它的Travis CI地址就是

&nbsp; [https://travis-ci.org/dreamhead/moco](https://travis-ci.org/dreamhead/moco)

最后，再来一个小技巧，为了让别人知道我们项目和Travis CI有关系，我们可以在自己项目的README上给出Travis CI的构建标识。在你的Travis CI项目页面上，你应该可以找到一个配置选项。写下本文时，它就是右上角那个小齿轮，里面有个Status Images。根据自己README格式选择一个，粘贴到README文件里。

好，大功告成，我们的开源项目也有了自己的CI。


