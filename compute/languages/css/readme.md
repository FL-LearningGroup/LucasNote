# Overview

CSS（层叠样式表）用于设置和布置网页 - 例如，更改内容的`字体`，`颜色`，`大小`和`间距`，将其拆分为多个列，或添加`动画`和其他装饰功能。

# Online CSS Editor

http://jsbin.com/?html,output

# CSS 布局

+ 弹性盒子： http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html
+ 网格布局: http://www.ruanyifeng.com/blog/2019/03/grid-layout-tutorial.html

# MDN CSS

https://developer.mozilla.org/zh-CN/docs/Learn/CSS

# CSS长度

+ 相对长度
+ 绝对长度

# 动画
http://www.ruanyifeng.com/blog/2014/02/css_transition_and_animation.html

1. 首先使用@keyframes创建动画规则。
2. 将动画规则绑定到html元素上。

```css
/*
动画是使元素从一种样式逐渐变化为另一种样式的效果。

您可以改变任意多的样式任意多的次数。

请用百分比来规定变化发生的时间，或用关键词 "from" 和 "to"，等同于 0% 和 100%。

0% 是动画的开始，100% 是动画的完成。

为了得到最佳的浏览器支持，您应该始终定义 0% 和 100% 选择器。
*/
@keyframes myfirst
{
    0%   {background: red; left:0px; top:0px;}
    25%  {background: yellow; left:200px; top:0px;}
    50%  {background: blue; left:200px; top:200px;}
    75%  {background: green; left:0px; top:200px;}
    100% {background: red; left:0px; top:0px;}
}
 
@-webkit-keyframes myfirst /* Safari 与 Chrome */
{
    0%   {background: red; left:0px; top:0px;}
    25%  {background: yellow; left:200px; top:0px;}
    50%  {background: blue; left:200px; top:200px;}
    75%  {background: green; left:0px; top:200px;}
    100% {background: red; left:0px; top:0px;}
}

div
{
    animation: myfirst 5s; /*myfirst 动画规则， 5s动画持续时间，默认0s*/
    -webkit-animation: myfirst 5s; /* Safari 与 Chrome */
}
```

# font

+ font-style: 为font-family指定倾斜角度， value: normal(default) | italic | oblique.
+ font-variant: 字体变体。
+ font-weight： 字体粗细程度。
+ font-size: 属性指定字体的大小。
+ line-height: 用于设置多行元素的空间量, 对于块级元素，它指定元素行盒（line boxes）的最小高度。
+ font-family: 允许您通过给定一个有先后顺序的，由字体名或者字体族名组成的列表来为选定的元素设置字体。

# Display

html元素可分为`块状元素(block)`，`行内元素(inline)`，`行内块状(inline-block)`元素(inline-block)

+ block

    (1)能够识别宽高

    (2)margin和padding的上下左右均对其有效

    (3)可以自动换行

    (4)多个块状元素标签写在一起，默认排列方式为从上至下

+ inline

    (1)设置宽高无效

    (2)对margin仅设置左右方向有效，上下无效；padding设置上下左右都有效，即会撑大空间

    (3)不会自动进行换行

+ inline-bloc

    (1)不自动换行

    (2)能够识别宽高

    (3)默认排列方式为从左到右

