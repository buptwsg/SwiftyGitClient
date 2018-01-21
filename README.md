# SwiftyGitClient
An iOS Github client APP implemented using pure Swift language.

第一步：了解Github的API  
第二步：了解网络库，ObjectMapper，在此基础上设计出网络层和模型方案。

API总结：  
Accept: 建议加上这个头，并设为applicationvnd.github.v3+json  
User-Agent: 请求的时候需要设置User-Agent头，值可以是用户名或是应用名。如果不加这个头，请求会被拒绝。   

Rate limiting: 对于OAuth，一个小时可以请求最多5000次。   

Pagination: 在分页请求的场合，不要自己去构造URL，而是使用Link Header中的值。  

OAuth应用已经创建。  
