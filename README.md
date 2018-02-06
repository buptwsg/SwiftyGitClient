# SwiftyGitClient
An iOS Github client APP implemented using pure Swift language.

# Github API总结
决定使用的是REST API v3  

Accept: 建议加上这个头，并设为applicationvnd.github.v3+json  
User-Agent: 请求的时候需要设置User-Agent头，值可以是用户名或是应用名。如果不加这个头，请求会被拒绝。   

Rate limiting: 对于OAuth，一个小时可以请求最多5000次。   

Pagination: 在分页请求的场合，不要自己去构造URL，而是使用Link Header中的值。    

拿到token的时候，还要检查返回的权限是否和请求的权限完全一样，因为用户可以修改授予的权限。

参考应用中用了一个开源的项目实现的API，本项目决定自己实现API。  



已知的一些iOS客户端：  
CodeHub  
Monkey for GitHub  
PPHub  
NapCat: 被人推荐，功能比较强大   
GitBucket

目标：参照以上APP，做一个自己的客户端产品，但是要超越已有产品。  

# 竞品分析
## CodeHub
OAuth认证流程不能正常工作，无法登录。   

## Monkey
* 第一个TAB：用户。根据所在位置（世界/国家，城市)，编程语言，列出用户的排名。点击一个用户进入个人主页。   
* 第二个TAB：仓库。根据选择的编程语言，列出仓库的排名，排序依据是star的数量。点击一个仓库进入仓库详情页。  
* 第三个TAB：发现。可以查看trending, showcases, 动态，可以搜索用户，仓库。  
* 第四个TAB：更多，里面有登录，关于，反馈三个功能。

不登录也可以玩，但是在登录的时候发现Oauth无法完成，登录不进去。

总体印象：  
功能比较简单   
很多关键的地方用了Webview来显示，这样又有什么意思呢？  

## GitBucket
国内雷纯峰写的，用了MVVM的架构。
* 第一个TAB： News。列出了当前用户的一些动态，例如：所关注的人关注了什么项目，创建了什么仓库，自己的项目被什么人关注了，fork了。
* 第二个TAB：Repositories。列出了自己相关的仓库：拥有的，关注的。其实是不是还应该分的更细：All, Public, Private, Sources, Forks，象Github网页版那样。
* 第三个TAB：发现。可以查看如下内容：Trending repositories this week（根据语言和时间范围），Popular repositories（根据语言），Popular users（根据国家和语言）。上方还有一个banner，需要去查一下拉取的是什么内容）。
* 第四个TAB：个人资料页。

缺的功能：  
创建仓库  
创建gist
仓库详情页面，不能查看Issues, Pull Requests, Contributors。  
个人页设置功能比较少，不能对仓库进行管理  
没有组织的相关功能  

总体印象：  
还是不错的，对我来说，第一步可以把这些功能都实现了，就已经不错了，可以拿来说事了。  

## PPHub
为了下载，还花了12元RMB。  
但实际上做的一般，并不比GitBucket强，界面上询问的TABBAR居然为白色。  

## NapCat
居然也是OAuth流程不工作，不知道是公司网络的原因，还是APP自身的问题。 

# API
## GET /users/:username/received_events
Watch仓库，或是关注用户以后，都会收到事件。如果当前用户是被认证的，那么能够看到私有的事件。否则只能看到公开的事件。

## GET /users/:username/events
List public events performed by a user

 

