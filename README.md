# SwiftyGitClient
An iOS Github client APP implemented using pure Swift language.

第一步：了解Github的API  
第二步：了解网络库，ObjectMapper，在此基础上设计出网络层和模型方案。

# Github API总结
决定使用的是REST API v3  

Accept: 建议加上这个头，并设为applicationvnd.github.v3+json  
User-Agent: 请求的时候需要设置User-Agent头，值可以是用户名或是应用名。如果不加这个头，请求会被拒绝。   

Rate limiting: 对于OAuth，一个小时可以请求最多5000次。   

Pagination: 在分页请求的场合，不要自己去构造URL，而是使用Link Header中的值。  

OAuth应用已经创建:  
Client ID: 85381c27c9a597de5b1d  
Client Secret: d23a3c20af26060c1548263197180fe5f3e89106  

OAuth认证的两个实现方式：  
Web application flow   
跳转到一个页面，输入用户名和密码，最后得到access token.   

Non-Web application flow  
用户输入用户名和密码，利用Basic Authentication来得到OAuth的token。  

拿到token的时候，还要检查返回的权限是否和请求的权限完全一样，因为用户可以修改授予的权限。

参考应用中用了一个开源的项目实现的API，本项目决定自己实现API。  


# Alamofire学习备忘
* 设置HTTP头部  
  对于不会变化的头部，建议通过URLSessionConfiguration来设置，不要在每次请求的时候临时去设置。  
  但是，Authorization和Content-Type这两个头部例外。




已知的一些iOS客户端：  
CodeHub  
Monkey for GitHub  
PPHub  
NapCat: 被人推荐，功能比较强大   

目标：参照以上APP，做一个自己的客户端产品，但是要超越已有产品。  
