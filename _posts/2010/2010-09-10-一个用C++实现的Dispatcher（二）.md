---
layout: post
title: 一个用C++实现的Dispatcher（二）
author: dreamhead
date: 2010-09-10 23:33:00 +0800
tags: [ '向上走', '咨询' ]
categories: [ '向上走', '咨询' ]
---

遗留代码就是遗留代码，总会有一些让人意想不到的地方，原以为所有消息都是由一个类（MsgHandler）处理的，可事实上，不是。  
if (msg-\>id == "open") {  
&nbsp;&nbsp;&nbsp; MsgHandler handler(msg);  
&nbsp;&nbsp;&nbsp; handler.open();  
} else if (msg-\>id == "close") {  
&nbsp;&nbsp;&nbsp; MsgHandler2 handler(msg);  
&nbsp;&nbsp;&nbsp; handler.close();  
} else if (…) {  
&nbsp;&nbsp;&nbsp; …  
} else {  
&nbsp;&nbsp;&nbsp; // exception handler  
&nbsp;&nbsp;&nbsp; …  
}  
  
上面的代码里面只有消息处理类的名字不同，其它的处理完全相同。不过，这样就让之前那个dispatcher就显得势单力薄。解决程序设计的问题，有一个很好用的处理手法：加个间接层。于是，  
class DispatchHandler {  
public:  
&nbsp;&nbsp;&nbsp; virtual void execute(Msg\* msg) = 0;  
};  
  
对于前面的两种类型，道理上来说，我们需要分别为两个类型（MsgHandler和MsgHandler2）分别编写对应的子类。不过，我们用的是C++，是的，模板：  
template\<typename T\>  
class DispatchHandlerImpl : public DispatchHandler {  
&nbsp;&nbsp;&nbsp; typedef void (T::\*Func)();  
public:  
&nbsp;&nbsp;&nbsp; DispatchHandlerImpl(Func sourceHandler)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :handler(sourceHandler) {}  
  
&nbsp;&nbsp;&nbsp; void execute(Msg\* msg) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T msgHandler(msg);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (msgHandler.\*(this-\>handler))();  
&nbsp;&nbsp;&nbsp; }  
  
private:  
&nbsp;&nbsp;&nbsp; Func handler;  
};

原来的dispatcher也要相应的调整：  
#include \<map\>  
  
class MsgDispatcher {  
public:  
&nbsp;&nbsp;&nbsp; ...  
&nbsp;&nbsp;&nbsp; void dispatch(Msg\* msg);  
private:  
&nbsp;&nbsp;&nbsp; std::map\<string, DispatchHandler\> handlers;  
};  
  
void MsgDispatcher::dispatch(Msg\* msg) {  
&nbsp;&nbsp;&nbsp; DispatchHandler\* handler = this-\>handlers[msg-\>id];  
&nbsp;&nbsp;&nbsp; if (handler) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler-\>execute(msg);  
&nbsp;&nbsp;&nbsp; } else {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // exception handler  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; …  
&nbsp;&nbsp;&nbsp; }  
}  
  
对应的注册代码也就变成：  
handlers["open"] = new DispatchHandlerImpl\<MsgHandler\>(&MsgHandler::open);  
handlers["close"] = new DispatchHandlerImpl\<MsgHandler2\>(&MsgHandler2::close);  
  
有代码洁癖的我们发现类名在这里重复了，于是，定义一个宏对其进行简化：  
#define DISPATCH\_HANDLER(className, funcName) \  
&nbsp; DispatchHandlerImpl \<className\>(&className::funcName)  
  
handlers["open"] = new DISPATCH\_HANDLER(MsgHandler, open);  
handlers["close"] = new DISPATCH\_HANDLER(MsgHandler2, close);


