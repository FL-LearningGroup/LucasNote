## [MSBuild](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019)
The Microsoft Build Engine is a platform for building application. This engine,which is also know as MSBuild, provide an xml schema for a project file that controls how the build platform process and build software.

## Visual Studio Build
The Visual Stduio use MSBuild to load and build managed project. But MSBuild doesn't depend on Visual Studio.

## [Dotnet](https://docs.microsoft.com/en-us/dotnet/core/tools/)
Currently Dotnet is built on top of MSBuild. But Dotnet has some features that aren't MSBuild, like **dotnet new**.
+ Use MSBuild in Dotnet: **dotnet msbuild**
