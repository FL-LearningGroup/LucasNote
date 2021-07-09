# Overview
Hosting provides the entry point for configuration and running your application。

# Dependencies
 + Analyzers
    - [Microsoft.CodeAnalysis.CSharp.NetAnalyzers](https://docs.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview): Inspect C# for code quality and style base on the rules.
    - Microsoft.CodeAnalysis.NetAnalyzers: Belongs to Microsoft.CodeAnalysis.CSharp.NetAnalyzers.
    - [Microsoft.CodeAnalysis.PublicApiAnalyzers](https://github.com/dotnet/roslyn-analyzers/blob/main/src/PublicApiAnalyzers/PublicApiAnalyzers.Help.md)
    - Microsoft.CodeAnalysis.PublicApiAnalyzers.CodeFixes: Belongs to Microsoft.CodeAnalysis.PublicApiAnalyzers.
    - Microsoft.Extensions.Logging.Generators
    - System.Text.Json.SourceGeneration
 + Assemblies
    - Microsoft.CodeAnalysis.PublicApiAnalyzers
    - Microsoft.Extension.Configuration
    - Microsoft.Extension.Configuration.EnvironmentVariables
    - Microsoft.Extension.Configuration.FileExtensions
    - Microsoft.Extension.DependencyInjection
    - Microsoft.Extension.FileProviders.Composite
    - Microsoft.Extension.FileProviders.Physical
    - Microsoft.Extension.Hosting
    - Microsoft.Extension.Logging
    - Microsoft.Extension.Options
 + Packages
    - Internal.AspNetCore.BuildTasks
    - MicroBuild.Core
    - Microsoft.AspNetCore.Internal.Transport
    - Microsoft.Net.Compilers.Toolset
    - Microsoft.SourceLink.AzureRepos.Git
    - Microsoft.SourceLink.GitHub
 + Projects
    - Microsoft.AspNetCore.Hosting.Abstractions
    - Microsoft.AspNetCore.Http
    - Microsoft.AspNetCore.Http.Extensions

## Interface and class
+ IHost
+ IHostedService
+ BackgroundService 
