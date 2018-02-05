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
## Monkey
* 第一个TAB：用户。根据所在位置（世界/国家，城市)，编程语言，列出用户的排名。点击一个用户进入个人主页。   
* 第二个TAB：仓库。根据选择的编程语言，列出仓库的排名，排序依据是star的数量。点击一个仓库进入仓库详情页。  
* 第三个TAB：发现。可以查看trending, showcases, 动态，可以搜索用户，仓库。  
* 第四个TAB：更多，里面有登录，关于，反馈三个功能。

不登录也可以玩，但是在登录的时候发现Oauth无法完成，登录不进去。

总体印象：  
功能比较简单   
很多关键的地方用了Webview来显示，这样又有什么意思呢？  

  
# 功能列表
