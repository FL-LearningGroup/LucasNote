### RESTFull Api应该使用URL和Request Method尽可能的唯一标记资源。
Examples:
+ Get api/customer/{id}
+ POST api/customer/{customerId}/birthday
+ PATCH api/customer/{customerId}/birthday/{birthdayId}
+ DELETE api/customer/{customerId}/birthday/{birthdayId}
+ POST  api/customer/{customerId}/delivery
+ DELETE api/customer/{customerId}/delivery/{deliveryId}
+ PATCH api/customer/{customerId}/delivery/{deliveryId}

### 接受数据进行更新
font-web发送数据有两种方式: 
1. 只发送更新的数据。
2. 发送一个整个对象，包含需要更新的和数据没有变化的。

理论: 从数据传输，和数据更新的操作考虑。数据应该只发送有价值的信息。

### 软件设计开发的设计点
**基础**
- 复用性，复用性可以降低代码的体积，但复用性也增加了代码的耦合度。
- 耦合度, 降低耦合度同时也会增加代码的复杂度。但是不同模块之间一定要使其达到松耦合。
    - 比如说，model与DB table, table column rename不能影响到model.

