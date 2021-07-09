## How to dynamically load and unload the DLL while the application is running?
+ Microsoft Relate Link: https://docs.microsoft.com/en-us/dotnet/standard/assembly/unloadability

## Overview
Starting with .NET Core 3.0,The ability to load and later unload a set of assemblies is supported. In .NET Framework, custom app domains were used for this purpose, But .NET Core only supports a signle default app domain.

## Difference between the Unloading using AssemblyLoadContext and using AppDomains.
**With AppDomains**, the unloading is forced. At unload time, all threads running in the target AppDomain are aborted, managed COM objects created in the target AppDomain are destroyed, and so on.
**With AssemblyLoadContext**, the unload is "cooperative". Calling the AssemblyLoadContext.Unload method **just initiates the unloading**. The unloading finishes after:
+ No threads have methods from the assemblies loaded into the AssemblyLoadContext on their call stacks.
+ None of the types from the assemblies loaded into the assemblyLoadContext, instance of those types, and the assemblies themselves are reference by:
  - References outside of the AssemblyLoadContext, except of weak reference(WeakReference or WeakReference<T>).
  - Strong garbage collector(GC) handles(GCHandleType.Normal or GCHandleType.Pinned) from both inside and outside of the AssemblyLoadContext.
