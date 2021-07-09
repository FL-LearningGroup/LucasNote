# Ref Question
https://sites.google.com/site/interviewsharing/asp-net/c-sharp-interview-questions-answers-part-1
Top 10 C# / .NET Multithreading Interview Questions: http://dotnetpattern.com/multi-threading-interview-questions
# Basic
+ Q1: Explain the value type and reference type
+ A1: Value types and reference types are the two main categories of C# types. A variable of a value type contains an instance of the type. This differs from a variable of a reference type, which contains a reference to an instance of the type. By default, on assignment, passing an argument to a method, and returning a method result, variable values are copied. In the case of value-type variables, the corresponding type instances are copied.

+ Q2: Is string value type or reference type ?
+ A2: The string is reference type.

+ Q3: What is Nullable<> ?
+ A3: A nullable value type T? represents all values of its underlying value type T and an additional null value. For example, you can assign any of the following three values to a bool? variable: true, false, or null

+ Q4: Explain ref and out keywords.
+ A4: 
  - params specifies that this parameter may take a variable number of arguments.

  - in specifies that this parameter is passed by reference but is only read by the called method.

  - ref specifies that this parameter is passed by reference and may be read or written by the called method. Must assigned value before pass into method.

  - out specifies that this parameter is passed by reference and is written by the called method.

+ Q5: Explain boxing and unboxing.
+ A5: https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/types/boxing-and-unboxing


+ Q6: What are differences between const, readonly and static?
+ A6: const keyword is used to create constant fields. readonly is a constant defined at runtime. const is used to create a constant at compile time. readonly field value can be changed after declaration.  
Constant and ReadOnly keyword is used to make a field constant which value cannot be modified. The static keyword is used to make members static that can be shared by all the class objects.

+ Q7: What is difference between throw and throw ex?
+ A7: 
  - throw : If we use "throw" statement, it preserve original error stack information. In exception handling "throw" with empty parameter is also called re-throwing the last exception.
  - throw ex : If we use "throw ex" statement, stack trace of exception will be replaced with a stack trace starting at the re-throw point. It is used to intentionally hide stack trace information.

+ Q8 What is difference between the Dispose() and Finalize()?
+ A8: https://sites.google.com/site/interviewsharing/asp-net/difference-between-finalize-and-dispose-methods-in-net

+ Q9: What is serialization?
+ A9: Serialization is the process of converting an object into a stream of bytes to store the object or transmit it to memory, a database, or a file. Its main purpose is to save the state of an object in order to be able to recreate it when needed. The reverse process is called deserialization.


+ Q10: What is the difference between binary serialization and XML serialization?
+ A10: Binary serialization preserves instance identity which mean entire object state is saved. 10. XML serialization does not preserve instance identity because in XML serialization only some of the object data is saved. Binary serialization is more efficient and faster than XML serialization.

+ Q11: Can you declare abstract property and event in abstract class?
+ A11: Yes

+ Q12: Can you declare property and event in interface?
+ A12: Yes

# Advantage
+ Q1: What is synchronization?
+ A1: Synchronization is a technique that allows only one thread to access the resource for the particular time. No other thread can interrupt until the assigned thread finishes its task.
  - We can use C# lock keyword to execute program synchronously. It is used to get lock for the current thread, execute the task and then release the lock. It ensures that other thread does not interrupt the execution until the execution finish.https://www.javatpoint.com/c-sharp-thread-synchronization#:~:text=Synchronization%20is%20a%20technique%20that,for%20the%20required%20execution%20time.
  
+ Q2: Explain managed resource and unmanaged resource.
+ A2: Managed resources are those that are pure . NET code and managed by the runtime and are under its direct control. Unmanaged resources are those that are not. File handles, pinned memory, COM objects, database connections etc

+ Q3: Explain managed code and unmanaged code
+ A3: Managed code is a code whose execution is managed by Common Language Runtime. ... C/C++ code, called "unmanaged code” do not have that privilege. The program is in binary that is loaded by the operating system into the memory. Rest, the programmer has to take care of.

+ Q4: What is lazy initialization and how to implement it?
+ A4: Lazy initialization of an object means that its creation is deferred until it is first used. 
https://docs.microsoft.com/en-us/dotnet/framework/performance/lazy-initialization

+ Q5: Explain IDisposable interface.
+ A6: Provides a mechanism for releasing unmanaged resources.

+ Q6: What is assembly?
+ A6: An assembly is a collection of types and resources that are built to work together and form a logical unit of functionality. Assemblies take the form of executable (.exe) or dynamic link library (.dll) files, and are the building blocks of .NET applications.

+ Q7: What is strong named assembly?
+ A7: Strong-naming an assembly creates a unique identity for the assembly, and can prevent assembly conflicts.

+ Q8: What is a private assembly?
+ A8: A private assembly is an assembly that is deployed with an application and is available for the exclusive use of that application. That is, other applications do not share the private assembly. Private assemblies are one of the methods that can be used to create isolated applications.
+ Q9: what is a shared assembly?

+ Q10: What is assembly manifest?
+ A10: The assembly manifest contains this assembly metadata. An assembly manifest contains all the metadata needed to specify the assembly's version requirements and security identity, and all metadata needed to define the scope of the assembly and resolve references to resources and classes. The assembly manifest can be stored in either a PE file (an .exe or .dll) with Microsoft intermediate language (MSIL) code or in a standalone PE file that contains only assembly manifest information.

# Design Pattern
https://medium.com/educative/the-7-most-important-software-design-patterns-d60e546afb0e

# algorithm
https://blog.csdn.net/wfq784967698/article/details/79551476
