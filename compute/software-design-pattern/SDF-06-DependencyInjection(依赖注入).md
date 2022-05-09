# 依赖注入(Dependency injection)
在软件工程中，依赖注入是对象在创建时接受它所依赖的对象技术。  
In software engineering, dependency injection is a technique in which an object receives other objects that it depends on.  
These other objects are called dependencies. In the typical "using" relationship the receiving object is called a client and the passed(that is, "injected")object is called a service.

# Dependency injection in .NET
https://docs.microsoft.com/en-us/dotnet/core/extensions/dependency-injection

### Driectly Depends
```csharp

//Dependency classs
public classs MessageWriter
{
  public void Write(string messsage)
  {
    Console.WriteLine(message);
  }
}

public class Worker: BackgroundService
{
  private readonly MessageWriter _messagerWriter = new MessageWriter();
  
  protect override async Task ExecuteAsync(CancellationToken stoppingToken)
  {
        while (!stoppingToken.IsCancellationRequested)
        {
            _messageWriter.Write($"Worker running at: {DateTimeOffset.Now}");
            await Task.Delay(1000, stoppingToken);
        }
  }
}
```
Result in problems:

+ To replace MessageWrite with a different implemention, The Worker class must be modified.
+ If MessageWriter has dependencies.The must also be configured through the Worker class.
+ The implemention is difficult to unit test. The app should use a mock or stub MessageWriter class, which isn't possible with this approach.

### Dependency injection
```csharp

namespace DependencyInjection.Example
{
    public interface IMessageWriter
    {
        void Write(string message);
    }
}

//-------------------------------
using System;

namespace DependencyInjection.Example
{
    public class MessageWriter : IMessageWriter
    {
        public void Write(string message)
        {
            Console.WriteLine($"MessageWriter.Write(message: \"{message}\")");
        }
    }
}

//--------------------------------
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace DependencyInjection.Example
{
    class Program
    {
        static Task Main(string[] args) =>
            CreateHostBuilder(args).Build().RunAsync();

        static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureServices((_, services) =>
                    services.AddHostedService<Worker>()
                            .AddScoped<IMessageWriter, MessageWriter>());
    }
}

//--------------------------------

using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;

namespace DependencyInjection.Example
{
    public class Worker : BackgroundService
    {
        private readonly IMessageWriter _messageWriter;

        public Worker(IMessageWriter messageWriter) =>
            _messageWriter = messageWriter;

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                _messageWriter.Write($"Worker running at: {DateTimeOffset.Now}");
                await Task.Delay(1000, stoppingToken);
            }
        }
    }
}
```
Addresses problems：
+ The use of an interface or base class to abstract the dependency implementation.
+ Registration of the dependency in a service container. .NET provides a built-in service container, IServiceProvider.
Services are typically registered at the app's start-up, and appended to an IServiceCollection. Once all services are added, you use BuildServiceProvider to create the service container.
+ Injection of the service into the constructor of the class where it's used. **The framework takes on the responsibility of creating an instance of the dependency and disposing of it when it's no longer needed.**
