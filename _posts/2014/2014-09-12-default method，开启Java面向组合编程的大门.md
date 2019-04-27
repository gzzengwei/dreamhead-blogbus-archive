---
layout: post
title: default method，开启Java面向组合编程的大门
author: dreamhead
date: 2014-09-12 17:42:00 +0800
tags: [ 'java8', 'default_method', '面向组合编程' ]
categories: [ 'java8', 'default_method', '面向组合编程' ]
---

“default method”是Java 8引入的一个特性，其初衷是为了解决既有程序库扩展的问题。在之前的Java版本中，如果要给一个已有接口添加新方法，这会带来一些问题，因为新方法没有对应的实现，所以，实现这个接口的类就会编译不通过。而“default method”的引入给了方法一个实现，编译就可以通过了，从而我们可以在不改变已有代码的前提下，为程序库增加新的方法。

但是，既然接口方法可以有实现，那它也给了我们另一种思路。

在Java开发中，我们可能会经常面临一种情况。以Web开发为例，假设我们有一个领域对象Foo。

class Foo {  
&nbsp; ...  
}

我们有个需求，根据其某些属性决定是否在页面上隐藏它。你当然用一个类实现它，但在页面上是否隐藏它，显然不应该属于领域对象的一部分。所以，我们通常会用另外一个类封装它，比如HiddenableFoo。

class HiddenableFoo extends Foo {  
&nbsp; boolean isHidden() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

好，新需求来了，我们要在页面上决定是否要给它的名字加粗，于是，这个类就成了HiddenableBoldableFoo。

class HiddenableBoldableFoo extends HiddenableFoo {  
&nbsp; boolean isBold() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

这里其实有个问题，为什么不是先由BoldableFoo，然后，从它继承呢？我们暂且不关心这个细节。

又有一个需求来了，在另一个页面，我们需要确定这个对象是否需要隐藏以及是否需要斜体：

class HiddenableItalicableFoo extends HiddenableFoo {  
&nbsp; boolean isItablic() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

又有一个页面，需要的判断一下某些地方是否要加粗，某些地方判断要斜体，那这个类要怎么做呢？

class BoldableItalicableFoo {  
&nbsp; boolean isBold() {  
&nbsp; &nbsp; ...  
&nbsp; }

&nbsp; boolean isItablic() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

如果这里的isBold和isItablic与前面的实现是一样的，是不是重复代码就此出现了呢？这就是在Java 8之前，我们面对的问题，我们可以继承接口，但实现不成。

Java 8来了，“default method”就给了我们一个机会，让我们可以继承实现。下面是一种实现：

interface Fooable {  
&nbsp; ...  
}

class Foo implments Fooable {  
&nbsp; ...  
}

interface Hiddenable extends Fooable {  
&nbsp; default boolean isHidden() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

interface Boldable extends Fooable {  
&nbsp; default boolean isBold() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

interface Italicable extends Fooable {  
&nbsp; default boolean isItablic() {  
&nbsp; &nbsp; ...  
&nbsp; }  
}

这里之所以引入一个Fooable接口，因为接口只能继承接口。有了这样的基础，我们就可以自由组合了，比如：

class HiddenableBoldableItalicableFoo extends Foo implements Hiddenable, Boldable, Italicable {  
}

如果你熟悉Ruby，这俨然就是Mixin，对于Scala粉丝来说，Trait已然呼之欲出，C++人则会看到多重继承的影子。是的，所有这些语言特性背后都有一个共同的理念：面向组合的编程。

Trygve Reenskaug和James Coplien在2009年提出的DCI架构，它是一种很好的面向对象编程的视角，其基础就是这种面向组合编程的理念。DCI架构在Java社区里面一直没有很好的讨论，也是因为Java语言没有给力的支持。

诚如前面所说，Java语言之前是不支持面向组合编程的，但是，在Java社区里，有人不断地做着这方面的探索，Rickard Oberg，这个前JBoss架构师，实现了一个[Qi4J](http://www.infoq.com/cn/articles/Composite-Programming-Qi4j)的框架。不过，现在Java语言本身也可以这么做了。

当然，相比于其它的语言，Java在这方面的表现力是有限的，因为它的基础是接口，所以：

- 它不能有字段
- 所有方法只能是public的

另外，组合只能是基于类来做，就像HiddenableBoldableItalicableFoo，虽然这个类除了声明什么都没有。相比于Ruby的Mixin这种可以在运行时扩展的特性，更是表现力要弱了许多。

但与之前的版本相比，Java算是在这个方面迈了一步，至少我们可以不用再为同一份代码多处出现而纠结了。


