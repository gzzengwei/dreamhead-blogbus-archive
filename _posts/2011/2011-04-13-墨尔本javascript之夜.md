---
layout: post
title: 墨尔本javascript之夜
author: dreamhead
date: 2011-04-13 20:19:00 +0800
tags: [ '脚下的路', 'javascript', '墨尔本' ]
categories: [ '脚下的路', 'javascript', '墨尔本' ]
---

ThoughtWorks对社区活动的支持总是不遗余力，这一点在哪都一样，我参加过北京、西安、班加罗尔的社区活动，见识过芝加哥办公室为活动准备的大场地。

今天，墨尔本，JavaScript之夜。

听完了，留在脑子里的东西有两个：[JQuery Address](http://www.asual.com/jquery/address/)和[Jasmine](http://pivotal.github.com/jasmine/)。

JQuery Address，根据我对所讲的理解，它可以在保持页面不刷新的情况下，更新URL。这有什么用呢？

今天早上和人讨论了SEO，其中一点是，URL是页面的一个很重要的标识，所以，不同的内容应该有不同的URL，但另一方面，不刷新页面，比如只用Ajax更新页面内容，对于用户体验来说又是非常重要的。好了，把这两点放在一起，通过JQuery Address，我们就可以在保证SEO的情况下，又给予用户良好的体验。

本质上来说，这不是JQuery特有的，而是“#”带给我们的便利，之前读到过[阮一峰](http://www.ruanyifeng.com/)的一篇文章《[URL的井号](http://www.ruanyifeng.com/blog/2011/03/url_hash.html)》，如今我终于这是怎么回事了。

Jasmine是一个JavaScript BDD框架。在这个Web页面越来越时尚的年代，作为一个开发人员，如果我们还在用最原始的方式写JavaScript的话，真会觉得脸上无光，更重要的是，会把自己累死。现在JavaScript也可以测试了，而且起点不低，直奔BDD而去。

Jasmine已经有了很好的集成方式，比如[和Ruby项目集成](https://github.com/pivotal/jasmine/wiki/A-ruby-project)，[和Rails项目集成](https://github.com/pivotal/jasmine/wiki/A-rails-project)，[和Node.js集成](https://github.com/mhevery/jasmine-node)，作为Java程序员，如果用Maven的话，也有[集成方式](https://github.com/searls/jasmine-maven-plugin)。除此之外，它还有[与Jquery的集成](https://github.com/velesin/jasmine-jquery)。还有人用[phantomjs](http://www.phantomjs.org/)，这样，在不开启界面的情况下，就可以运行Jasmine。

不白走一趟，这两个话题刚好是最近脑子里在想的话题，可以在项目里面尝试一下。听说下次有人讲页面上的MVC：[backbones](http://documentcloud.github.com/backbone/)。多好的社区活动啊！


