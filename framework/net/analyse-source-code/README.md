# NETSourceCode

## Deep of understand .net

+ https://mattwarren.org/

## 2021-03-25
1. Git clone code. https://github.com/dotnet/runtime/blob/main/docs/workflow/README.md

2. Build project.

## 2021-03-29
1. Load dll to execute. Reference docs: https://github.com/dotnet/runtime/blob/main/docs/workflow/debugging/coreclr/debugging.md

## 2021-04-16
1. Investigate function
  + coreclr_initialize
  + coreclr_execute_assembly
  + coreclr_shutdown_2

D:\dotnet\runtime\src\coreclr\src\dlls\mscoree\unixinterface.cpp

## 2021-04-21
1. How JIT compiles IL?
  + https://www.52pojie.cn/thread-1005018-1-1.html
  + https://mattwarren.org/2018/07/05/.NET-JIT-and-CLR-Joined-at-the-Hip/
