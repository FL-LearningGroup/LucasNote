# Http request 分类
将请求分为页面请求(Pages)，和行为请求(Action)。

+ Page request: 页面请求是为了使用ASP.NET MVC提供的构建页面的功能，比如Layout. 页面请求只返回纯的前端页面，不包含ASP.NET 的模型绑定和cshtml嵌入的的语法

+ Action request: 行为请求是为使用Rest Api规范。采用fetch方法发生请求。

# Response 分类
+ 请求正常返回的状态码为200，body格式如下
```
{
实际数据
}
```
+ 请求错误，body格式如下
```
{
    'code': 'number，代表错误类型'
    'message': 'string, 反馈给客户的错误详细信息'
    'exception': 'object,详细的错误信息'，
    'help': 'post url,用来提交错误信息'
}
```
# Service Pages Api
## Dress

+ Create
+ Update
+ List

# Service Actions Rest Api
## Dress
+ GET api/dress/{id}
+ POST api/dress
+ PATCH api/dress/{id}
+ DELETE api/dress/{id}
+ GET api/dress/list
+ GET api/dress/list/pagination
+ POST api/dress/{id}/imgUpload
