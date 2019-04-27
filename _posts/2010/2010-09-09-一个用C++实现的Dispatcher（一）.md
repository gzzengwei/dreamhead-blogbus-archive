---
layout: post
title: 一个用C++实现的Dispatcher（一）
author: dreamhead
date: 2010-09-09 23:04:00 +0800
tags: [ '向上走', '咨询' ]
categories: [ '向上走', '咨询' ]
---

又和一个团队合作，面前又摆着一堆分发的代码，不同的是，这次用的是C++：  
if (msg-\>id == "open") {  
&nbsp;&nbsp;&nbsp; MsgHandler handler(msg);  
&nbsp;&nbsp;&nbsp; handler.open();  
} else if (msg-\>id == "close") {  
&nbsp;&nbsp;&nbsp; MsgHandler handler(msg);  
&nbsp;&nbsp;&nbsp; handler.close();  
} else if (…) {  
&nbsp;&nbsp;&nbsp; …  
} else {  
&nbsp;&nbsp;&nbsp; // exception handler  
&nbsp;&nbsp;&nbsp; …  
}  
  
不要问我为什么不是每个消息对应一种处理类，要是知道为什么，就不是遗留代码了。于是，我们尝试着用C++写了一个dispatcher。下面是这个dispatcher的声明：  
#include \<map\>  
  
typedef void (MsgHandler::\*handlerFunc)();  
  
class MsgDispatcher {  
public:  
&nbsp;&nbsp;&nbsp; ...  
&nbsp;&nbsp;&nbsp; void dispatch(Msg\* msg);  
private:  
&nbsp;&nbsp;&nbsp; std::map\<string, handlerFunc\> handlers;  
};  
  
因为要处理遗留代码，这里用到了指向成员函数的指针，也就提高了理解这段代码的门槛。具体实现如下：  
void MsgDispatcher::dispatch(Msg\* msg) {  
&nbsp;&nbsp;&nbsp; handlerFunc func = this-\>handlers[msg-\>id];  
&nbsp;&nbsp;&nbsp; if (func) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MsgHandler msgHandler(pkg);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (msgHandler.\*func)();  
&nbsp;&nbsp;&nbsp; } else {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // exception handler  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; …  
&nbsp;&nbsp;&nbsp; }  
}  
  
注册很简单：  
handlers["open"] = &MsgHandler::open;  
handlers["close"] = &MsgHandler::close;


