## Overview
程序集是.NET程序的部署，版本管控，重用，有效范围以及安全权限的基础单元。程序集是类型和资源的集合，为CLR运行时提供了类型信息。
Assembiles form the fundamental units of development, version control, reuse, activation scoping, and security permissions for .NET-based applications.
They provide the common language runtime with the information it needs to be aware of type implementations.

## Assembly Content
Includes List:
+ Mainfest, which contains assembly metadata
+ Type metadata
+ MSIL(Micrsoft intermediate language)
+ a set of [resource](https://docs.microsoft.com/en-us/dotnet/framework/resources/)

![A single-file assembly called MyAssembly.dll](https://github.com/dotnet/docs/blob/master/docs/standard/assembly/media/contents/single-file-assembly.gif)

## Assembly manifest
程序集清单描述了程序集的元数据，导出的元数据。类似于table的样式
程序集可分为static or dynamic,whether static or dynamic.都包含了collection of data that describes how the elements in the assembly relate to each other.
The assembly can be store in PE(Portable executable) file.

The following illustration shows the different ways the manifest can be stored.

![Diagram that shows the manifest in a single-file assembly and multifile assembly configuration.](https://github.com/dotnet/docs/blob/master/docs/standard/assembly/media/manifest/assembly-types-diagram.gif)  

**You can add or change some information in the assembly manifest by using assembly attributes in your code.**

## Following properties
+ Assemblieds are implemented as .exe or .dll files.
+ GAC(globa assembly cache) for share assemblies between applications. But must Strong-name assembiles before you can include them in the GAC.
+ Lazy loading, only loaded into memory if they are required. If they aren't used, they aren't loaded.
+ Get assembly info during runtime using Reflection
+ During loading assembly during runtime.

## Following information
+ Have only one entry point: DllMain, WinMain, or Main
+ Security boundary
+ Type boundary
+ Reference scop boundary
+ Version boundary
+ Deployment unit
+ Side-by-side execution unit.

## Category
### Staic assembly
Static assemblies are stored on disk in portable executable(PE) files.Static assemblies can include interface, class, and resources like bitmaps, JPEG files,  
and other resource files.

### Dynamic assembly
Can create dynamic assembly, which are run directly from memory and aren't saved to disk before execution. you can save dynamic assembiles to disk after they have executed. Can use System.Reflection.Emit to creare it dynamic assemblies.

## Assembly manifest
+ The assembly's identity (its name and version).
+ A file table describing all the other files that make up the assembly, such as other assemblies you created that your .exe or .dll file relies on, bitmap files, or Readme files.
+ An assembly reference list, which is a list of all external dependencies, such as .dlls or other files. Assembly references contain references to both global and private objects. Global objects are available to all other applications. 
