**参考资源**
+ 什么是REST: http://restful.p2hp.com/
+ 理解RESTful架构: https://www.ruanyifeng.com/blog/2011/09/restful.html
+ RESTful API 设计指南: https://www.ruanyifeng.com/blog/2014/05/restful_api.html

客户端/服务器模式的兴起，改变了软件开发的模式。C/S模式建立在分布式体系上，通过互联网通信，具有高延时（high latency）、高并发等特点。

C/S将软件开发和网络联系在一起，软件开发主要针对单机环境，网络则主要研究系统之间的通信。互联网的兴起，使得两个领域开始融合。

## 什么是RESTful

资源(Resource)表现层(Representational)状态(State)转移(Transfer)

**资源(Resource)**

代表网络上的一个实体，或者说网上的一个具体信息。他是一段文本，一张图片，一首歌曲，一种服务，总之就是一个具体的实在。可以用一个URI(Uniform Resource Indentifier)指向它，每种资源对应一个特定的URI.要获取这个资源，访问它URI就可以，因此URI就成了每一个资源的地址或独一无二的识别符。

**表现层(Representational)**

资源(Resource)是一种信息实体，它可以有多种外在的变现形式。我们把“资源”具体呈现出来的形式，叫做它的“表现层"。

比如，文本可以用txt格式表现，也可以用HTML格式、XML格式、JSON格式表现，甚至可以采用二进制格式；图片可以用JPG格式表现，也可以用PNG格式表现。

URI只代表资源的实体，不代表它的形式。严格地说，有些网址最后的".html"后缀名是不必要的，因为这个后缀名表示格式，属于"表现层"范畴，而URI应该只代表"资源"的位置。它的具体表现形式，应该在HTTP请求的头信息中**用Accept和Content-Type字段指定，这两个字段才是对"表现层"的描述。**

**状态(State)转移(Transfer)**

访问一个网站，就代表了客户端和服务器的一个互动过程。在这个过程中，**势必涉及到数据和状态的变化。**

互联网通信协议HTTP协议，是一个无状态协议。这意味着，所有的状态都保存在服务器端。因此，如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化"（State Transfer）。而这种转化是建立在表现层之上的，所以就是"表现层状态转化"。

客户端用到的手段，只能是HTTP协议。具体来说，就是HTTP协议里面，四个表示操作方式的动词：**GET、POST、PUT、DELETE。**


**满足RESTful架构六个约束：**

1. Uniform Interace: 一个资源有唯一的URI。

2. Client–server：C/S架构，两者独立发展。

3. Stateless: 无状态，Server不会保存Client端的任何状态。

4. Cacheable: 可缓存了，带来性能的改善。

5. Laguered System： 分层系统, 你可以把APIs 部署在serverA, 数据存储在servreB, 验证请求在ServerC.

6. Code on demand(optional): 按需代码

**根据[Microsoft Graph](https://docs.microsoft.com/en-us/graph/use-the-api)定义Http verbs**
|**Method** |**Description**                             |
| :----- | :------------------------------------------- |
| GET    | Read data from a resource.                   |
| POST   | Create a new resource, or perform an action. |
| PATCH  | Update a resource with new values.           |
| PUT    | Replace a resource with a new one.           |
| DELETE | Remove a resource.                           |