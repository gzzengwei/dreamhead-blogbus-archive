---
layout: post
title: Hello, Weka
author: dreamhead
date: 2008-03-11 16:55:00 +0800
tags: [ '向上走' ]
categories: [ '向上走' ]
---

Weka，是一个用Java编写的数据挖掘软件。数据挖掘，从字面上来看，它是一个从数据中找寻有用信息的过程，不过，它涉及的内容很多，所以，这里借用“分类”这一面来说事。  
  
分类，从名称上来看，再简单不过了，给你一样东西，给它分个类。你如何知道怎么分类呢？显然，这是基于你已有的经验。对于计算机而言，这种经验从何而来呢？只有让人来告诉它，也就是说，我们要拿一批数据训练计算机，经过训练的计算机，便具备了一定的识别能力，就可以完成一些简单的分类工作。现实中，可以用到分类的机会有很多，比如我之前，曾经参与过的一个项目就是用这种方法来做车辆的识别。  
  
下面便是一段使用Weka完成一段分类程序。  
  
import weka.classifiers.Classifier;  
import weka.classifiers.bayes.NaiveBayesMultinomial;  
import weka.core.Attribute;  
import weka.core.FastVector;  
import weka.core.Instance;  
import weka.core.Instances;  
import weka.filters.Filter;  
import weka.filters.unsupervised.attribute.StringToWordVector;  
  
public class Main {  
&nbsp; private static final String GOOD = "G";  
&nbsp; private static final String BAD = "B";  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static final String CATEGORY = "category";  
&nbsp; private static final String TEXT = "text";  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static final int INIT\_CAPACITY = 100;  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static final String[][] TRAINING\_DATA = {   
&nbsp;&nbsp;&nbsp; {"Good", GOOD},  
&nbsp;&nbsp;&nbsp; {"Wonderful", GOOD},  
&nbsp;&nbsp;&nbsp; {"Cool", GOOD},  
&nbsp;&nbsp;&nbsp; {"Bad", BAD},  
&nbsp;&nbsp;&nbsp; {"Disaster", BAD},  
&nbsp;&nbsp;&nbsp; {"Terrible", BAD}  
&nbsp; };  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static final String TEST\_DATA = "Good";  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static Filter filter = new StringToWordVector();  
&nbsp; private static Classifier classifier = new NaiveBayesMultinomial();  
&nbsp;&nbsp; &nbsp;  
&nbsp; public static void main(String[] args) throws Exception {  
&nbsp;&nbsp;&nbsp; FastVector categories = new FastVector();   
&nbsp;&nbsp;&nbsp; categories.addElement(GOOD);  
&nbsp;&nbsp;&nbsp; categories.addElement(BAD);  
  
&nbsp;&nbsp;&nbsp; FastVector attributes = new FastVector();  
&nbsp;&nbsp;&nbsp; attributes.addElement(new Attribute(TEXT, (FastVector)null));  
&nbsp;&nbsp;&nbsp; attributes.addElement(new Attribute(CATEGORY, categories));  
  
&nbsp;&nbsp;&nbsp; Instances instances = new Instances("Weka", attributes, INIT\_CAPACITY);  
&nbsp;&nbsp;&nbsp; instances.setClassIndex(instances.numAttributes() - 1);  
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;  
&nbsp;&nbsp;&nbsp; for (String[] pair : TRAINING\_DATA) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String text = pair[0];  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String category = pair[1];  
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Instance instance = createInstanceByText(instances, text);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance.setClassValue(category);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instances.add(instance);  
&nbsp;&nbsp;&nbsp; }  
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;  
&nbsp;&nbsp;&nbsp; filter.setInputFormat(instances);  
&nbsp;&nbsp;&nbsp; Instances filteredInstances = Filter.useFilter(instances, filter);  
&nbsp;&nbsp;&nbsp; classifier.buildClassifier(filteredInstances);  
  
&nbsp;&nbsp;&nbsp; // Test  
&nbsp;&nbsp;&nbsp; String testText = TEST\_DATA;  
&nbsp;&nbsp;&nbsp; Instance testInstance = createTestInstance(instances.stringFreeStructure(), testText);  
  
&nbsp;&nbsp;&nbsp; double predicted = classifier.classifyInstance(testInstance);  
&nbsp;&nbsp;&nbsp; String category = instances.classAttribute().value((int)predicted);  
&nbsp;&nbsp;&nbsp; System.out.println(category);  
&nbsp; }  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static Instance createInstanceByText(Instances data, String text) {  
&nbsp;&nbsp;&nbsp; Attribute textAtt = data.attribute(TEXT);  
&nbsp;&nbsp;&nbsp; int index = textAtt.addStringValue(text);  
  
&nbsp;&nbsp;&nbsp; Instance instance = new Instance(2);  
&nbsp;&nbsp;&nbsp; instance.setValue(textAtt, index);  
&nbsp;&nbsp;&nbsp; instance.setDataset(data);  
  
&nbsp;&nbsp;&nbsp; return instance;  
&nbsp; }  
&nbsp;&nbsp; &nbsp;  
&nbsp; private static Instance createTestInstance(Instances data, String text) throws Exception {  
&nbsp;&nbsp;&nbsp; Instance testInstance = createInstanceByText(data, text);  
&nbsp;&nbsp;&nbsp; filter.input(testInstance);  
&nbsp;&nbsp;&nbsp; return filter.output();  
&nbsp; }  
}  
  
这个程序分成两个大部分，前半部分用以训练分类器，后半部分则是测试这个分类器。  
  
训练分类器，我们要做的包括，选择分类算法和准备训练数据。在Weka中，每一种分类算法都是Classifier的一个子类，这样的话，就可以在不改变其它部分的情况下，很容易的修改分类算法。  
  
其实，稍微了解一下这方面的知识的人，都会知道，分类算法固然重要，但真正决定一个分类器本事大小的，是用以训练的数据。想要得到一个好的分类器，少不了不断调整训练数据和不断的训练。这同人类认识问题是一样的，经得多，见得广，才有更好的分辨能力。

在Weka中，用以训练的数据就是Instances，顾名思义，这是Instance的复数，显而易见，单独的一个训练数据就是Instance，而Instances这个类的存在，可以把Instance的一些公共的属性放到一起。在这里，我们可以看到，为了用文本作为训练数据，我们会把文本转换为Instance。同样，测试分类器的时候，我们也会把文本转换为一个Instance，然后再进行分类。  
  
除此之外，这里还有一个Filter的概念，同常见的filter概念类似，它给了我们一个进行正式处理之前，对数据进行处理的机会。在这里，主要是对Instance做一些相关的变换。  
  
当我们得到一个分类器之后，就可以利用这个分类器进行分类了，其中，最关键的代码是  
&nbsp;&nbsp;&nbsp; classifier.classifyInstance(testInstance);  
这段代码返回的是根据分类算法计算结果得到的一个相似度，我们可以利用这个值来估计我们测试用的数据应该属于哪个分类。  
  
从代码上来说，这段代码本身并不复杂。正如前面所说，一个好的分类器是需要让数据帮忙的。所以，换几个测试数据，你就会发现，这段代码中实现的分类器一点都不强大。如果希望它强大起来，扩展训练数据是一个必然的结果。不过，对于这篇blog而言，这不重要，因为我们只是要和Weka问个好，进一步的工作，还需要进一步的努力。


