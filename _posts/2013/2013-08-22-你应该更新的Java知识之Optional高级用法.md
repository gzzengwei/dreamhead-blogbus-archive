---
layout: post
title: 你应该更新的Java知识之Optional高级用法
author: dreamhead
date: 2013-08-22 09:09:00 +0800
tags: [ '你应该更新的Java知识', 'Java', 'Guava', 'Null', 'Optional', 'Maybe_Monad' ]
categories: [ '你应该更新的Java知识', 'Java', 'Guava', 'Null', 'Optional', 'Maybe_Monad' ]
---

[你应该更新的Java知识之常用程序库（一）  
](http://dreamhead.blogbus.com/logs/226738702.html)[你应该更新的Java知识之常用程序库（二）  
](http://dreamhead.blogbus.com/logs/226738756.html)[你应该更新的Java知识之构建工具  
](http://dreamhead.blogbus.com/logs/227427912.html)[你应该更新的Java知识之Observer  
](http://dreamhead.blogbus.com/logs/231594181.html)[你应该更新的Java知识之集合初始化  
](http://dreamhead.blogbus.com/logs/232899025.html)[你应该更新的Java知识之集合操作  
](http://dreamhead.blogbus.com/logs/234113759.html)[你应该更新的Java知识之惰性求值  
](http://dreamhead.blogbus.com/logs/234741366.html)[你应该更新的Java知识之Optional](http://www.blogbus.com/logs/235329092.html)

介绍了[Optinal的基本用法](http://www.blogbus.com/logs/235329092.html)，我们来看一个有趣的例子，找到一个人的出生国家。按照传统的思路，代码大约是这个样子：

Place place = person.getPlaceOfBirth();  
if (place != null) {  
&nbsp;City city = place.getCity();  
&nbsp;if (city != null) {  
&nbsp; &nbsp;Province province = city.getProvince();  
&nbsp; &nbsp;if (province != null) {  
&nbsp; &nbsp; &nbsp;return province.getCountry();  
&nbsp; &nbsp;}  
&nbsp;}  
}

return null;

如果你对整洁代码稍有追求，这样的if套if都会让你觉得不爽。让我们尝试用Optional改造它，不过，事先声明一下，以下代码并不在Guava代码库里，而是自行的扩展，也是弥补Guava Optional的缺失，你可以把下面的代码添加到你自己的程序库中，作为基础代码：

首先，我们要给Optionals添加一个方法：

public class Optionals {  
&nbsp; &nbsp;public static \<T, U\> Optional&nbsp;bind(Optional value,  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Function\<T, Optional\> function) {  
&nbsp; &nbsp; &nbsp;if (value.isPresent()) {  
&nbsp; &nbsp; &nbsp; return function.apply(value.get());  
&nbsp; &nbsp; }

&nbsp; &nbsp; return absent();  
&nbsp; }  
}  
（参见[具体代码](https://github.com/dreamhead/jfun/blob/master/src/main/java/com/github/dreamhead/jfun/optional/Optionals.java)）

这个方法的意图是，对一个Optional值（value）执行一个操作（function），如果value不是空，则对value执行操作，否则，返回空。

如果单纯从这个函数，你还不是很清楚它到底能做些什么，那我们就直接来看代码：

bind(  
&nbsp;bind(  
&nbsp; &nbsp;bind(  
&nbsp; &nbsp; &nbsp;bind(personOptional, getPlaceOfBirth()), &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  
&nbsp; &nbsp; &nbsp;getCityFromPlace()),  
&nbsp; &nbsp;getProvinceFromCity()),  
&nbsp;getCountryFromProvince());

我们连着用了几个bind连Person对象里一层一层地往外找我们所需的值，如你所料，这里的每个函数实际上都是一个函数对象，我们就以其中的一个演示一下基本的做法：

Function\<Province, Optional\> getCountryFromProvince() {  
&nbsp;return new Function\<Province, Optional\>() {  
&nbsp; &nbsp;@Override  
&nbsp; &nbsp;public Optional apply(Province input) {  
&nbsp; &nbsp; &nbsp;return fromNullable(input.getCountry());  
&nbsp; &nbsp;}  
&nbsp;};  
}

把所有这些放在一起你就应该理解了，在这中间执行的任何一个环节如果出现空值，那么整个的返回值就是一个空值，否则，它就会一层一层的执行下去。

这样一来，如果我们把bind函数视为程序库里的函数，那我们的客户端代码里面，一个if都没有出现，我们成功地消除那一大堆的if嵌套。

不过，这种括号套括号的用法颇有Lisp风味，作为一个Java程序员，我们对于这样的写法还着实需要适应一下。让我们再进一步探索一下，看看怎么能把它做得更Java一些。

public class FluentOptional {  
&nbsp; &nbsp;private Optional optional;

&nbsp; &nbsp;private FluentOptional(Optional optional) {  
&nbsp; &nbsp; &nbsp;this.optional = optional;  
&nbsp; }

&nbsp; public static FluentOptional from(Optional optional) {  
&nbsp; &nbsp; &nbsp;return new FluentOptional(optional);  
&nbsp;}

&nbsp; public&nbsp;FluentOptional&nbsp;bind(Function\<T, Optional\> function) {  
&nbsp; &nbsp; &nbsp;if (isPresent()) {  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return from(function.apply(get()));  
&nbsp; &nbsp; &nbsp;}

&nbsp; &nbsp; &nbsp; return from(Optional.absent());  
&nbsp;}

&nbsp; ...

（参见[具体代码](https://github.com/dreamhead/jfun/blob/master/src/main/java/com/github/dreamhead/jfun/optional/FluentOptional.java)）

通过这段代码，我们可以用FluentOptional提供一个对Optional类的封装，这里面我们新增了两个方法from和bind，其它方法都是可以由Optional提供，实现很容易，这里省略了。我们看看通过这个新实现，我们的方法变成了什么模样：

from(personOptional)  
&nbsp; .bind(getPlace())  
&nbsp; .bind(getCityFromPlace())  
&nbsp; .bind(getProvinceFromCity())  
&nbsp; .bind(getCountryFromProvince());

怎么样，如此一来，代码就就像Java代码了吧！

实际上，这种做法也是来自一种函数式编程的理念：Maybe Monad，这是Haskell程序设计语言为探索纯函数式编程所做的努力之一，这里就不做过多的介绍了。


