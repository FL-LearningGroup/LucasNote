## Concept
+ Task-base asynchronous programming: https://docs.microsoft.com/en-us/dotnet/standard/parallel-programming/task-based-asynchronous-programming
+ Asynchronous programming: https://docs.microsoft.com/en-us/dotnet/csharp/async

## The Relation between Task and Async 
+ The async belong to CSharp, The task belong to NET.  
(Reference Microsoft Docs: The C# has a languange-level asynchronous programming code. for easily writting asynchronous code, The core fo asynchronous programming is the Task and Task<T> object)
+ So the async/await is grammar-sugar for easily to operate Task.

## Task
### Function
+ Create
+ Run
+ Start
+ Wait
+ Delay
+ Continue
+ Complete

## Async/Await
The async default return Task/Task<TResult>
