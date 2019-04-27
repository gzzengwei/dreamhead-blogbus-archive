---
layout: post
title: Hello, Modernizr
author: dreamhead
date: 2011-06-18 19:04:00 +0800
tags: [ 'modernizr', 'html5', 'css3', 'web' ]
categories: [ 'modernizr', 'html5', 'css3', 'web' ]
---

 **简介**  
在HTML5和CSS3逐渐成为主流之际，不同浏览器的能力成为构建网站的一个挑战，Modernizr应运而生。Modernizr如是介绍自己：

Modernizr is an open-source JavaScript library that helps you build the next generation of HTML5 and CSS3-powered websites.

**下载**  
如果要下载production版本的modernizr，我们会发现，它提供的并不是一个one-size-fits-all的解决方案，而是我们可以根据自己的需要进行订制。在其[下载页面](http://www.modernizr.com/download/)上，我们选择自己所需的HTML和CSS特性，然后生成一个javascript文件。这么做会极大程度上减少冗余代码，减少不必要的检测，对web前端这个很看重用户体验的地方，性能就是一点一点压出来的。当然，development版本会给我们提供更全面的内容。

**安装**  
下面是一个使用了modernizr的极简页面：  
&nbsp; \<!DOCTYPE html\>  
&nbsp; \<html class="no-js"\>  
&nbsp; \<head\>  
&nbsp; &nbsp; \<script src="modernizr.js"\>\</script\>  
&nbsp; \</head\>  
&nbsp; \<body\>  
&nbsp; \</body\>  
&nbsp; \</html\>

在这里，有两点需要我们关注。其一自然是我们放置了modernizr.js。按照现在通常的理解，javascript应该放置页面的底部，保证加载javascript时页面已经加载完毕，提升整体的性能。但是，modernizr必须放在\<head\>里，最好放在css声明之后，因为HTML5 Shiv（用以在IE中启用HTML元素）必须在\<body\>之前执行，而且要使用modernizr添加的class，需要阻止[FOUC](http://bluerobot.com/web/css/fouc.asp/)。

另外一个关注点在于html声明里的no-js的class。它设置了一个默认状态，如果页面禁用了javascript我们就可以知道了。

如果一切正常，打开页面调试工具，我们就会看到modernizr的工作成果，下面是用firefox 4的firebug打开看到的内容。

\<html class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop no-websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity no-cssanimations csscolumns cssgradients no-cssreflections csstransforms no-csstransforms3d csstransitions fontface generatedcontent video audio localstorage no-sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"\>

通过这段代码，浏览器的能力就一目了然了，所有以“no-”开头的，就是这个浏览器不支持的特性。

**使用**  
有了这些检测，接下来就是这些检测的结果。我们的主要关注点在于两个方面，CSS和JavaScript。

对CSS，我们可以根据不同的特性对于样式进行不同的配置，比如，下面这段  
&nbsp; .webgl h1 {  
&nbsp; &nbsp; color: blue;  
&nbsp; }

&nbsp; .no-webgl h1 {  
&nbsp; &nbsp; color: red;  
&nbsp; }

如果我们在页面上使用了h1，在Firefox 4和Safari 5上打开页面，就会看到不同颜色的字体。

同样，我们也可以在JavaScript利用这些特性检测的结果，下面是一段利用了JQuery写出的代码：  
&nbsp; $(function() {  
&nbsp; &nbsp; if (Modernizr.webgl) {  
&nbsp; &nbsp; &nbsp; $('h1').text('webgl');  
&nbsp; &nbsp; } else {  
&nbsp; &nbsp; &nbsp; $('h1').text('no-webgl');  
&nbsp; &nbsp; }  
&nbsp; });

有了这段代码，Firefox 4和Safari 5也会有不同的表现。

无论从哪个角度看来，到处都是if判断都会把代码弄得乱七八糟。所以，modernizr提供了一种机制，分离不同的代码：  
&nbsp; Modernizr.load({  
&nbsp; &nbsp; test: Modernizr.webgl,  
&nbsp; &nbsp; yep : 'webgl.js',  
&nbsp; &nbsp; nope: 'no-webgl.js'  
&nbsp; });

有的，归有的，没有的，就没有。Modernizr.load本身扮演着一个resource loader的角色，它会根据检测的结果进行资源加载，换句话说，要么是加载了webgl.js，要么是加载no-webgl.js，而不会二者都加载。

如果直接用的是development版本的modernizr，你会发现，根本就没有Modernizr.load，因为它是作为一个单独文件发布的：yepnope.js。而在production版本，我们选择将其包含在modernizr里。

这就是对modernizr的一个基本介绍，就让我们在modernizr的协助下，共同走上HTML5的康庄大道吧！


