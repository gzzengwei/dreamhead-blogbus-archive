---
layout: post
title: ThoughtWorks CodeJam
author: dreamhead
date: 2008-04-21 17:24:00 +0800
tags: [ '脚下的路' ]
categories: [ '脚下的路' ]
---

周末没得闲，因为参加了一次CodeJam。  
  
CodeJam，是公司组织的一个编程活动，就是要在周末两天时间内开发出一个东西，据说此类的活动在其他的办公室举办过。这是我第一次参加类似的活动，参加这次活动的Dev都是公司内比较优秀的程序员，平时很难把这些人都放到一个团队里面，有机会和这些人在一起工作，本身就是一件令人期待的事。  
  
这次活动的目标是为一个支援乡村教育的组织开发一个分享平台。在活动开始之前，我们对需求一无所知，所以，几乎就是看两天内能够写出多少东西。因为这个项目要开发的是一个Web应用，从生产率的角度来看，我们当仁不让的选择了Rails作为开发工具，这也是我最近在[学习Rails](http://dreamhead.blogbus.com/logs/19324827.html)的原因之一。  
  
万事开头难，这次CodeJam也不例外。在一群Dev准备甩开膀子大干一场的时候，我们发现了一个问题，没有需求。需求，是[冰云](http://blog.nona.name/)（BA）和[QQ](http://qihuiqihui.spaces.live.com/)（QA）在之前一天和我们的客户谈好的。QQ在离开办公室之前，把从需求整理出的Story卡片锁到了自己的抽屉里，结果，第二天，她闹肚子了。好在冰云临危不惧，顶着我们的巨大压力，把部分Story重写了出来。直到QQ重新归队，打开宝箱，需求问题才得到了彻底的解决。  
  
正式开工，场面那是相当壮观。一群ThoughtWorker，一群快手，一帮人抢着提交代码。做用户登录部分的高喊着，他们应该是第一个提交数据库表的，结果，更新代码时，已经有了数据库版本已经到了3。那是我和WPC干的，因为我们俩负责搭建开发环境，所以，先下手为强了。不过，我们高兴得有些过，用scaffold生成的代码出现了一个拼写错误。这时我们才发现，修改这些生成代码是多么痛苦的一件事。  
  
在这里，我们用的典型的ThoughtWorks工作方式，一对Pair，拿到一张Story卡，然后，小步前进：测试、编码、重构、提交。正是因为步幅很小，所以，就出现了大家争抢着提交代码，因为稍微慢一点，就会更新下来一片代码，这种时候，便要重新运行测试。运气不好的话，破坏了别人的测试，还要帮别人修复。其实，在一个大的开发团队中，这种现象很常见，尤其是测试多到不能很快运行完，比如有集成测试的时候，常常是运行测试之后，又来了新代码。  
  
典型的ThoughtWorks工作方式，还有另外一个含义。一群人一边写着代码，一边互相开着玩笑。在我的印象中，ThoughtWorks开发团队从来就不缺少笑声。其实，这次参加CodeJam的人，有很多我并没有直接在一起工作过，所以，这也是一个很好的了解大家的机会。比如，在我的印象中，WPC一直是闷着头写代码的家伙，和他Pair才知道，他原来也是那么有才，可以让人笑得肚子疼。至于像[徐X](http://www.blogjava.net/raimundox/)和[gigix](http://gigix.thoughtworkers.org/)这种平日里就给大家很多欢乐的家伙（也许也包括我自己）就更不用说了。当然，也有比较安静的，[亮亮](http://hl.thoughtworkers.org/)和来自加拿大的[Ricky](http://www.rickylui.com/blog/)被我评为“最安静的Pair“。  
  
两天下来，从无到有，一个具备基本功能的网站就建立了起来。showcase的时候，看着这个小网站，心里还是很有一丝满足的。对我而言，这是我第一次做Rails项目，第一次尝试用TextMate去开发。

这次CodeJam，是在公司内部进行的，希望将来有机会把这个面扩大一些，让其他公司的人来和我们一起来做，一方面我们可以从其他人身上学习到一些东西，另一方面，也让别人了解一下ThoughtWorks是如何工作的。我相信在如何进行软件开发这个问题上，ThoughtWorks做得足够好。

**UPDATE**  
其他的ThoughtWorker也有对这次活动发表了自己的看法。  
冰云：[Beijing Code Jam - 2 days agile development project](http://blog.nona.name/200804274.html)  
Ricky：[CodeJam@Thoughtworks Beijing](http://www.rickylui.com/blog/2008/04/20/codejamthoughtworks-beijing/)


