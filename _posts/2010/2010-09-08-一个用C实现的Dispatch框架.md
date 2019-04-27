---
layout: post
title: 一个用C实现的Dispatch框架
author: dreamhead
date: 2010-09-08 22:30:00 +0800
tags: [ '向上走', '咨询' ]
categories: [ '向上走', '咨询' ]
---

用条件语句做分发是一件很常见的事：  
switch(msg-\>id) {  
&nbsp;&nbsp;&nbsp; case ID1:   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID1Handler(msg);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;  
&nbsp;&nbsp;&nbsp; case ID2:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID2Handler(msg);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;  
&nbsp;&nbsp;&nbsp; ...  
}  
  
条件稍微多一些点，函数就会变得冗长不堪。有的团队会直接用if..else，进行判断，于是我们有幸知道了，VC不支持超过128个的选择分支。为了让这种代码的可维护性更好，我们做了一些尝试。  
  
下面定义了一个dispatcher：  
BEGIN\_DISPATCHER(MSG, ID, MsgHandler)  
&nbsp;&nbsp;&nbsp; DISPATCH\_ITEM(ID1, ID1Handler)  
&nbsp;&nbsp;&nbsp; DISPATCH\_ITEM(ID2, ID2Handler)  
END\_DISPATCHER(DisasterHandler)  
  
首先，用BEGIN\_DISPATCH\_MAP定义了这个dispatcher的名字（MSG），用做分发键值的类型（ID）和处理函数的类型（MsgHandler）。接下来，用DISPATCH\_ITEM定义了几个分发项，也就是说，如果传入的值是ID1，会用ID1Handler进行处理，如果是ID2，则对应着ID2Handler。最后，用END\_DISPATCH\_MAP定义了一个错误处理函数。这样的话，就把使用的时候，就不必额外去做判空的操作了。这是Null Object模式的一种体现。  
  
这个dispatcher的使用方式如下：  
dispatch(to(MSG), with(msg-\>id))(msg);  
  
这段代码的含义是使用MSG这个dispatcher，根据msg-\>id找到对应的处理函数，传入的参数是msg。  
  
这个dispatch框架的实现如下：  
#include   
#define SIZE\_OF\_ARRAY(array) sizeof(array)/sizeof(array[0])  
  
/\* dispatcher definition \*/  
  
#define \_\_DISPATCHER\_NAME(name) \_\_dispatcher\_##name  
#define \_\_DISPATCH\_ITEM\_NAME(name) \_\_dispatch\_item\_##name  
#define \_\_IsMatched(target, source) (0 == memcmp(&target, &source, sizeof(target)))  
  
#define BEGIN\_DISPATCHER(name, key\_type, handler\_type) \  
&nbsp;&nbsp;&nbsp; struct \_\_DISPATCH\_ITEM\_NAME(name) {\  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; key\_type key;\  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler\_type \*handler;\  
&nbsp;&nbsp;&nbsp; };\  
&nbsp;&nbsp;&nbsp; \  
handler\_type\* \_\_DISPATCHER\_NAME(name)(key\_type key) \  
{\  
&nbsp;&nbsp;&nbsp; static struct \_\_DISPATCH\_ITEM\_NAME(name) dispatchers[] = {\  
  
#define END\_DISPATCHER(disaster\_handler) \  
&nbsp;&nbsp;&nbsp; };\  
&nbsp;&nbsp;&nbsp; int i;\  
&nbsp;&nbsp;&nbsp; int array\_size = SIZE\_OF\_ARRAY(dispatchers); \  
&nbsp;&nbsp;&nbsp; for (i = 0; i \< array\_size; i++)\  
&nbsp;&nbsp;&nbsp; {\  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (\_\_IsMatched(dispatchers[i].key, key)) {\  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dispatchers[i].handler;\  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }\  
&nbsp;&nbsp;&nbsp; }\  
&nbsp;&nbsp;&nbsp; return disaster\_handler;\  
}  
  
#define DISPATCH\_ITEM(key, handler) {key, handler},  
#define DISPATCH\_ITEM\_2(key1, key2, handler) {key1, key2, handler},  
#define DISPATCH\_ITEM\_3(key1, key2, key3, handler) {key1, key2, key3, handler},  
#define dispatch(name, key) \_\_DISPATCHER\_NAME(name)(key)  
#define to(name) name  
#define with(key) key  
  
从这里可以看出，定义dispatcher，实际上是定义了一个函数，这个函数的返回值是一个函数指针，而这个函数指针的类型是由handler\_type定义的。这样的话，就解决了不同dispatcher之间函数参数不同的问题。  
  
当然，这个处理里面采用了最简单的数组，在分发项不是很多的情况下是适用的。如果分发项较多，可以考虑改为map实现。另外，这里还运用了一些宏的技巧。在写应用代码时，我们并不鼓励多用宏。但写一些框架代码，为了提高使用上的表现力时，宏也会是一个利器。  
  
如果有兴趣，欢迎讨论！


