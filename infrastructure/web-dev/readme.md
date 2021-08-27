# 从头开始打造工具链

**Ref Link:**
+ https://zh-hans.reactjs.org/docs/create-a-new-react-app.html#creating-a-toolchain-from-scratch
+ SwiperJs Demo: https://swiperjs.com/demos#default

**一组 JavaScript 构建工具链通常由这些组成：**

+ 一个 package 管理器，比如 Yarn 或 npm。它能让你充分利用庞大的第三方 package 的生态系统，并且轻松地安装或更新它们。
+ 一个打包器，比如 webpack 或 Parcel。它能让你编写模块化代码，并将它们组合在一起成为小的 package，以优化加载时间。
+ 一个编译器，例如 Babel。它能让你编写的新版本 JavaScript 代码，在旧版浏览器中依然能够工作。

搭建指南：https://blog.usejournal.com/creating-a-react-app-from-scratch-f3c693b84658

# 信息网站
+ [out]: https://www.smashingmagazine.com/

# 网站类型

+ **单页面应用：** 单页面应用(single-page application)，是一个应用程序，它可以加载单个 HTML 页面，以及运行应用程序所需的所有必要资源（例如 JavaScript 和 CSS）。与页面或后续页面的任何交互，都不再需要往返 server 加载资源，即页面不会重新加载。
    - ref link: http://tinyambition.com/Single-Page-App-Break/%E7%AC%AC01%E7%AB%A0%20%E4%BD%95%E4%B8%BA%E5%8D%95%E9%A1%B5%E5%BA%94%E7%94%A8.html
+ **服务器渲染和客户端渲染:** https://juejin.cn/post/6844903959241424910

# 不同渲染方式在浏览器解析情况

+ 解析URL
+ 浏览器本地缓存
+ DNS解析
+ 建立TCP/IP连接
+ 发送HTTP请求
+ 服务器处理请求并返回HTTP报文
+ 浏览器根据深度遍历的方式把html节点遍历构建DOM树
+ 遇到CSS外链，异步加载解析CSS，构建CSS规则树
+ 遇到script标签，如果是普通JS标签则同步加载并执行，阻塞页面渲染，如果标签上有defer / async属性则异步加载JS资源
+ 将dom树和CSS DOM树构造成render树
+ 渲染render树

# manifest.json file

# 素材网站

+ 调色板: https://paletton.com/
+ 贝塞尔曲线:https://cubic-bezier.com/#.26,.59,.74,.45
+ 图标: https://www.flaticon.com/
+ Loding: https://loading.io/

# Responsive layout

响应式布局实际上是为了解决元素位置和大小适应屏幕尺寸的变化。

# 组件开发

开发组件，应该只关注组件自身(只影响自身CSS属性)。组件最外出html element应该禁止使用margin

# 如何在没有数据的情况下，搭建页面

**数据是通过Http从服务端获取数据**
为了之后能平滑的切换，前端应利用接口定义模拟http请求。