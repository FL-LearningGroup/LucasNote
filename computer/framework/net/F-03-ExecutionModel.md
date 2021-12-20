---
title: Summary microsoft doc of the execution model.
date: "2020/11/20"
author: LucasYao
---
## Overview
.NET Provides a run-time environment, called the common language runtime.that runs the code and provides service that make the development process easier.

## Code work with CLR
To enable the runtime to provides service to managed code. language compilers must emit metadata that describes the types, member, and references in your code.  
The CLR uses metadata to locate and local classes.lay out instances in memory,resolve method invokations,generate native code,enforce security, and set run-time context boundaries.

## IL
The language compilers compiling source code to IL.

## JIT(Just-In-Time)
The CLR covert IL to native code using JIT during application running.  
JIT compilation rule: it converts the MSIL as needed during execution and stores the resulting native code in memory so that it is accessible for subsequent calls in the context of that process.

## MetaData
.Net makes component interoperation even easier by allowing compilers to emit additional declarative information into all modules and assembiles.This information,  
called metadata,helps components to interact seamlessly.

### MetaData store the following info
+ Description of assembly

  - Identity(name, version,culture, public ke)
  
  - The types that are exported
  
  - Other assemblies the this assembly depends on
  
  - Security permissions needed to run
  
+ Description types

  - Name, visbility, base classm and interfaces implemented
  
  - Member(methods,fields,properties,events,nested types)
  
+ Attributes

  - Additional descriptiive elements that modify types and members.
  
## WorkFlow

```mermaid
graph LR
sc[SourceCode] --> |Compile|c[Compilation]
c --> |Generation|IL[Intermediate Language]
c --> |Generation|md[MetaData]
md --> |as part of file| IL
ec[Execute Code] -.-> |Executed loads|md
md -.-> |discover informarion|gi[Class, Members, Inheritance and so on]
 ```
