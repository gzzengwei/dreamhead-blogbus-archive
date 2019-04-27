---
layout: post
title: Hello, Lucene
author: dreamhead
date: 2008-01-07 13:46:00 +0800
tags: [ '向上走' ]
categories: [ '向上走' ]
---

[Lucene](http://lucene.apache.org/)是什么？下面是官方回答。  
  
Apache Lucene is a high-performance, full-featured text search engine library written entirely in Java.  
  
简而言之，它是用来做搜索的库。提及搜索，我们的思绪就会情不自禁飞到串匹配上。没错，串匹配确实是一种搜索，但对于不同的应用，搜索的方法不一样，对于在一篇文档中进行搜索这种小规模应用而言，串匹配足够了，而Lucene为我们向大规模搜索铺上了一条大道。大规模？是不是想到了搜索引擎，事实上，Lucene就是被很多人用来构建搜索引擎。  
  
关于搜索引擎的实现，很多人或多或少的听说过一些，比如网络爬虫，比如分布式的架构，比如PageRank。抛开其它其它复杂的部分，最关键的步骤便是建立索引，然后进行搜索。不妨让我们Lucene是如何实现这最关键的部分。  
  
import java.io.File;  
import java.io.FileReader;  
  
import org.apache.lucene.analysis.standard.StandardAnalyzer;  
import org.apache.lucene.document.Document;  
import org.apache.lucene.document.Field;  
import org.apache.lucene.index.IndexWriter;  
  
public class Indexer {  
&nbsp;&nbsp;&nbsp; public static void main(String[] args) throws Exception {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File indexDir = new File("index");  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File dataDir = new File("data");  
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IndexWriter indexWriter = null;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; try {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indexWriter = new IndexWriter(indexDir, new StandardAnalyzer(), true);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (File file : dataDir.listFiles()) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (file.isFile() && file.getName().endsWith(".txt")) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Document document = new Document();  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Field pathField = new Field("path", file.getCanonicalPath(),  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Field.Store.YES, Field.Index.TOKENIZED);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; document.add(pathField);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Field contentField = new Field("contents", new FileReader(file));  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; document.add(contentField);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indexWriter.addDocument(document);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indexWriter.optimize();  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } finally {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (indexWriter != null) {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indexWriter.close();  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }  
&nbsp;&nbsp;&nbsp; }  
}  
  
这段代码很容易理解，遍历数据目录下的文本文件，为每个文件生成索引。  
  
这里有一个Document的概念，它在Lucene表示的是索引和搜索的单位，也就是说，建立索引，是以Document为单位的，搜索也是以Document为单位的。Document中有一堆的Field，我们可以把它们理解为Document中一个一个小节。有了Field，我们可以为Document添加一些属性，比如这里，我们就添加了路径（path）和内容（content）两个属性。这样，搜索之后，我们可以利用这些属性提供更多的信息，比如，告诉别人搜索的词出现在哪个文档中。  
  
上面的代码中，我们可以清楚看到，建立Document，并向其中插入Field的过程。有了Document，我们就可以把它借助IndexWriter将它们写入索引中，至于最后的optimize，显然是为了让搜索更有效率而存在的。  
  
有了索引，那就该进行下一步的工作，搜索。  
  
import org.apache.lucene.document.Document;  
import org.apache.lucene.index.Term;  
import org.apache.lucene.search.Hits;  
import org.apache.lucene.search.IndexSearcher;  
import org.apache.lucene.search.Query;  
import org.apache.lucene.search.TermQuery;  
  
public class Searcher {  
&nbsp;&nbsp;&nbsp; public static void main(String[] args) throws Exception {  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String type = "contents";  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String key = "game";  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String path = "index";  
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IndexSearcher searcher = new IndexSearcher(path);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Term t = new Term(type, key);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Query query = new TermQuery(t);  
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hits hits = searcher.search(query);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(int i = 0; i \< hits.length(); i++){  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Document document = hits.doc(i);  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; System.out.println("File: " + document.get("path"));  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }  
&nbsp;&nbsp;&nbsp; }  
}  
  
IndexSearcher是用来在索引中进行搜索主要帮手，前提是我们要告诉它到索引在哪。Term表示文本中的一个词，它说明了我们要在哪个Field（type）中找什么（key）。然后，我们用Term做成一个Query，表示我们要进行搜索了。做好准备，接下来，就是搜索了。搜索的结果叫做Hits。遍历这个Hits，便可以将搜索结果一一展示出来。如前面所说，这里利用路径这个属性报告搜索的结果。  
  
有了Lucene做基础，能做的事就很多了，比如搭建一个搜索引擎。事实上，已经有了这样的开源项目，比如与Lucene同出一门的[Nutch](http://lucene.apache.org/nutch/)，比如比Nutch年纪更大的[Compass](http://www.opensymphony.com/compass/)。 


