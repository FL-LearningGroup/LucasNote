## Definition -- Software Design Pattern
it is a description or template for how to solve a problem that can be used in many different situations. Design patterns are formalized best practices that the programmer can use to solve common problems when designing an application or system.

为了代码编程工程化和代码的复用

## Definition -- Object-oriented design pattern
It show relationships and interactions between classes or objects.

## 菜鸟提供的设计模式教程
https://www.runoob.com/design-pattern/design-pattern-tutorial.html

## Foreign Website
https://sourcemaking.com/design_patterns

https://refactoringguru.cn/

## Wiki
https://en.wikipedia.org/wiki/Software_design_pattern

## GOF(四人帮，Fang of Four)
他们提出的设计模式主要是基于以下的面向对象设计原则
+ 对接口编程而不是对实现编程。（接口代表的是提供功能的API)
+ 优先使用对象组合而不是继承

## 设计模式六大原则
1. 开闭原则(Open Close Principle)： 对扩展开放，对修改关闭。
2. 里氏替换原则(Liskov Substitution Principle)： 任何基类出现的地方，子类都能实现。
3. 依赖倒转原则(Dependence Inversion Principle)： 针对接口原则，依赖于抽象而不依赖于具体。
4. 接口隔离原则(Interface Segregation Principle)： 使用多个接口隔离，降低依赖，降低耦合。
5. 迪米特法则，又称最少原则(Demeter Principle): 一个实体应最少地与其它实体之间发送相互作用，使得系统模块相对独立。
6. 合成复用原则(Compoiste Reuse Principle): 尽量使用合成/聚合的方式，而不是使用继承。

## 23种设计模式
+ :exclamation: 功能拆分到接口中，也就是接口定义功能。
+ :exclamation: 使用接口，隔离对象，降低类之间的耦合性。

| 模式分类 | 名字| 使用场景 | 关系 |
| :-: | :-:| - | :-: | 
| 创建型 | 工厂模式<br>(Factory Pattern) | 同一个接口的提供了不同的功能<br>Example:<br> 1. 日志记录器：记录可能记录到本地硬盘、系统事件、远程服务器等，用户可以选择记录日志到什么地方。<br>2. 设计一个连接服务器的框架，需要三个协议，"POP3"、"IMAP"、"HTTP"，可以把这三个作为产品类，共同实现一个接口。| interface :one: ---> :asterisk: object|
| 创建型 | 抽象工厂<br>(Abstract Factory Pattern | 多个工厂生成同一个产品，将多个工厂封装成单个的抽象工厂 | abstract :one: ---> :asterisk: object |
| 创建型 | 单例模式<br>(Singleton Pattern) |整个程序运行期间构建一个instance.<br>example:<br>1、要求生产唯一序列号。<br>2、WEB 中的计数器，不用每次刷新都在数据库里加一次，用单例先缓存起来。<br>3、创建的一个对象需要消耗的资源过多，比如 I/O 与数据库的连接等| :one: object |
| 创建型 | 建造者模式<br>(Builder Pattern) | 使用多个简单的对象一步一步构建一个复杂的对象,对象的组成部分经常性变化。<br> example:<br>  1、去肯德基，汉堡、可乐、薯条、炸鸡翅等是不变的，而其组合是经常变化的，生成出所谓的"套餐"。<br> 2、JAVA 中的 StringBuilder。| :one: object ---> :asterisk: object |
| 创建型 | 原形模式<br>(Prototype Pattern) | 用于创建重复对象，同时又能保证性能 | :one: origin-object ---> :asterisk: object |
| 结构型 | 适配器模式<br>(Adapter Pattern) | 作为两个不兼容的接口之间的桥梁, （:point_down:不常用） | :one: target-interface ---> :one: adapter-interface ---> :one: origin-interface |
| 结构型 | 桥接模式<br>(Bridge Pattern) | 使用接口让抽象类和它的实现类分离。实际上就是将抽象的功能性拆分到接口中 | :one: interface ---> :one: abstract ---> :asterisk: object |
| 结构型 | 过滤器模式<br>(Filter Pattern) | 从对象的集合中获取指定的条件的对象 | :asterisk: object ---> :asterisk: interface |
| 结构型 | 组合模式<br>(Composite Pattern) | 部分和整体，部分可执行CRUD,增加整体的可扩展性 | :one: object ---> :asterisk: object |
| 结构型 | 装饰者模式<br>(Decorator Pattern) | 向一个现有的对象添加新的功能，同时又不改变其结构 | :one: interface ---> :one: abstract ---> :asterisk: object |
| 结构型 | 外观模式<br>(Facade Pattern) |隐藏系统的复杂性，并向客户端提供了一个客户端可以访问系统的接口。这种类型的设计模式属于结构型模式，它向现有的系统添加一个接口，来隐藏系统的复杂性。 | :one: maker-object ---> :one: interface ---> :asterisk: object
| 结构性 | 享元模式<br>(Flyweight Pattern) | 减少创建对象的数量，以减少内存占用和提高性能<br> Example:<br> 1、JAVA 中的 String，如果有则返回，如果没有则创建一个字符串保存在字符串缓存池里面。 2、数据库的数据池。 | :one: object ---> :asterisk: object |
| 结构型 | 代理模式<br>(Proxy Pattern) | 一个类代表另一个类的功能 | :one: object ---> :one: interface ---> :one: object |
| 行为型 | 责任链模式<br>(Chain of responsibillity Patthern) | 为请求创建了一个接收者对象的链。这种模式给予请求的类型，对请求的发送者和接收者进行解耦<br>Example: 1、Asp.net core route 拦截。<br> 2、JS 中的事件冒泡。 <br>3、JAVA WEB 中 Apache Tomcat 对 Encoding 的处理，Struts2 的拦截器，jsp servlet 的 Filter|
| 行为型 | 命令模式<br>(Command Pattern)| 命令接受和命令的执行隔离 | :one: invoke-object ---> :one: interface ---> :asterisk: recive-object |
| 行为型 | 解释器模式<br>(Interpreter Pattern) | :point_down: 不常用 |
| 行为型 | 迭代器模式<br>(Iterator Pattern) | Jave和.Net编程环境中常用的设计模式。这种模式用于顺序访问集合对象的元素，不需要指定对象的底层表示。) | :one: object ---> :one: interface |
| 行为型 | 中介者模式<br>(Mediator Pattern) | 用来降低多个对象和类之间的通信复杂性 | :one: object ---> :one: object ---> :one: object
| 行为型 | 备忘录模式<br>(Memento Pattern) | 保存一个对象的某个状态，以便在适当的时候恢复对象。备忘录模式属于行为型模式。| :one: originator-object ---> :one: memento-object <--- :one: caretaker-object|
| 行为型 | 观察者模式<br>(Observer Pattern) | 当一个对象被修改时，自动通知依赖它的对象 | :one: object ---> :asterisk: object |
| 行为型 | 状态模式<br>(State Pattern) | 类的行为是基于它的状态改变 | :one: interface ---> :one: state-object ---> :one: context-object |
| 行为型 | 空对象模式<br>(Null Object Pattern) | 一个空对象取代NULL对象实例的检查。Null对象不是检查空值，而是反应一个不做任何动作的关系。| :one: abstract ---> :asterisk: (instance/null)object |
| 行为型 | 策略模式<br>(Strategy Pattern) | 一个类的行为或其算法在运行时是动态改变的 | :one: interface --> :asterisk:implemention-object ---> :one: context-object |
| 行为型 | 模板模式<br>(Template Pattern) | 定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。| :one: abstract ---> :asterisk: implemention-object|
| 行为型 | 访问者模式<br>(Visitor Pattern) | 需要对一个对象结构中的对象进行很多不同的并且不相关的操作，而需要避免让这些操作"污染"这些对象的类，使用访问者模式将这些封装到类中 | :one:accept-interface ---> :one: accept-object ---> :one: visitor-interface ---> :one: visitor-object |

## J2EE模式
设计模式特别关注表示层。
| 名字 | 使用场景 | 关系 |
| :--- | :--- | :--- |
| MVC模式<br>(Model-View-Controller) | 隔离模型和输出。 |
| 业务代表模式<br>(Business Delegate Pattern)| 用于对表示层和业务层解耦。 |
| 组合实体模式<br>(Composite Entity Pattern) |
| 数据访问对象模式<br>(Data Access Object Pattern）| DAO 模式用于把低级的数据访问 API 或操作从高级的业务服务中分离出来。 |
| 前端控制器模式<br>(Front Controller Pattern) | 用来提供一个集中的请求处理机制，所有的请求都将由一个单一的处理程序处理。该处理程序可以做认证/授权/记录日志，或者跟踪请求，然后把请求传给相应的处理程序。|
| 拦截过滤器模式<br>(Intercepting Filter Pattern) | 用于对应用程序的请求或响应做一些预处理/后处理。定义过滤器，并在把请求传给实际目标应用程序之前应用在请求上。过滤器可以做认证/授权/记录日志，或者跟踪请求，然后把请求传给相应的处理程序。|
| 服务定位器模式<br>(Service Locator Pattern) | 服务定位器模式充分利用了缓存技术，服务定位器在 JNDI 中查找服务，并缓存该服务对象。当再次请求相同的服务时，服务定位器会在它的缓存中查找，这样可以在很大程度上提高应用程序的性能。|
| 传输对象模式<br>(Transfer Object Pattern) | 传输对象是一个具有 getter/setter 方法的简单的 POJO 类，它是可序列化的，所以它可以通过网络传输。它没有任何的行为。|
