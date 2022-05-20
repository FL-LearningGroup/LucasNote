## CMake

## MSVC == Microsoft Visual C++
MSVC is a compiler for the C, C++, and C++/CLI programming languages by Microsoft. MSVC is properietary software;

It was originally a standalone produce but later became a part of Visual studio and made available in both trialware and freeware forms.

It features tools for developing and debugging C++ code, especially code write for the [Winodws API](https://en.wikipedia.org/wiki/Windows_API), [DirectX](https://en.wikipedia.org/wiki/DirectX) and .NET.


## VC folder structure
+ Microsoft Visual Studio\2019\Community\VC
  - Auxiliary: Inlcudes tools that compile native code.
  - Redist
  - Tools: Includes MSVC tools
### Use MSVC to compile code on the command line.
VC/Build/vcvarsall.bat ---call---> MSVC ---compile code ---> Native Code

## CMake

+ Remove **CMakeCache.txt** and **CMakeFile** folder before building project.

# What is HMODULE ?
stackoverflow: https://stackoverflow.com/questions/9545732/what-is-hmodule

## Relational knowledage

+ GetProcAddress function
If the function succeeds, the return value is the address of the exported function or vaiable.

https://docs.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-getprocaddress


# What is a Windows Handle?

https://stackoverflow.com/questions/902967/what-is-a-windows-handle

It's an abstract reference value to a resource, often memory or an open file, or a pipe.

Properly, in Windows, (and generally in computing) a handle is an abstraction which hides a real memory address from the API user, allowing the system to reorganize physical memory transparently to the program. 

Resolving a handle into a pointer locks the memory, and releasing the handle invalidates the pointer.

# .NET JIT

https://www.52pojie.cn/thread-1005018-1-1.html

```csharp
static void Main()
{
  Console.WriteLine("Hello");
  Console.WriteLine("Goodbye");
}
```csharp
JIT编译以上代码。
1. 再Main函数执行前，CLR会检测出Main代码的所有引用类型(根据元数据),CLR分配一个内部数据结构来管理对引用类型的访问。

# How .NET application to load and execute ?

在windows平台，windows会检查EXE文件，决定是创建32 bit还是64 bit的进程后，会在进程地址空间加载MSCorEE.dll的x86, x64或ARM版本。

然后，进程的主进程调用MSCorEE.dll中定义的一个方法，该方法初始化CLR，加载EXE程序集，再调用入口函数(Main)。随机，托管应用程序启动，运行。

```txt

| Windos | ---check .exe ---> |create 32 bit or 64 bit process| ---base cpu---> |load MSCorEE.dll| ---> |Call function of mscoree.dll| ---> |init CLR| ---> |load exe assembly| ---> |Call entry function(Main)| ---> runing

```
