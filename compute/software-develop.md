**软件建立在模型上**
作为软件开发工程师，目的就是将事物，想法，现实映射到计算机世界中。
模型，是构建计算机世界的基础。

## 什么是模型？
模型是对对象(代表任何可见可想的事物)属性和行为的封装。

## 如何构建模型？

1. 分析对象的属性和行为（自身）。


## 软件的特性
高内聚，低耦合。

## 优先考虑
- 模型
    - .NET中所有的引用类型都继承了`object`, 所有的引用类型都可以转换为Object.
- 接口
- 泛型

## 如何捕获异常
1. 当是可处理的异常，我们应该在抛出异常的方法里进行修复。
2. 不应该捕获所有异常，这样会导致异常不能及时发现。
3. 不可处理的异常，应该冒泡式的抛出到最外出方法进行捕获处理。
