# About React

A JavaScript library for building user interfaces.

# Lifecycles

https://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/

# React base on TypeScript

## Usual Type
+ React.Component<props, states>

## React Fragments – What, Why, How

+ Abroad: https://dev.to/tumee/react-fragments-what-why-how-2kh1


# `State` 

## `setState` function is asynchronous

Calling setState function updates the state asynchronously. This means that when setState is called, the state is not guaranteed to be updated right away. 

It is not a good practice to read this.state right after calling stetState because the state might not yet be updated to the new value.

## Don't use `this.state` inside setState

This is related to the previous one. It is not reliable to use this.state inside setState function. 

If you want to update the state based on the previous state, updater function should be used. setState accepts an updater function as a parameter and previous state is passed to it.

```js
// This is not reliable
this.setState({ counter: this.state.counter + 1 });

// You should use the updater function, like this
this.setState((prevState) => {
  return { counter: prevState.counter + 1 };
});
```
You can find detailed explanations on how setState works from the [React docs](https://reactjs.org/docs/react-component.html#setstate).

TypeScript在React中使用总结: https://segmentfault.com/a/1190000016526361

## Hook

+ 使用Hook可以在无需修改组件结构的情况下复用状态逻辑。
+ 在非class的情况下可以使用更多的React特性。

**使用规则**

+ 只能在函数最外层调用`Hook`,不要在循环，条件判断或者子函数中调用。
+ 只能在React的函数组件中或者在自定义Hook中调用Hook。 不要在其他JavaScript函数中调用