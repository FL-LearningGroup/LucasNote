# Offical website
https://docs.microsoft.com/en-us/dotnet/core/extensions/dependency-injection

# Sample code
https://cmatskas.com/net-core-dependency-injection-with-constructor-parameters-2/

```csharp
using Microsoft.Extensions.DependencyInjection;
using System;

namespace NetCoreDIDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            var services = new ServiceCollection();
            services.AddTransient<IMyService>(s => new MyService("MyConnectionString"));
            var provider = services.BuildServiceProvider();
            var myService = provider.GetService<IMyService>();
            
            Console.WriteLine($"The constructor parameter is: {myService.GetConstructorParameter()}");
            Console.ReadKey();
        }
    }

    public interface IMyService
    {
        string GetConstructorParameter();
    }

    public class MyService : IMyService
    {
        private string connectionString;
        public MyService(string connString)
        {
            this.connectionString = connString;
        }

        public string GetConstructorParameter()
        {
            return connectionString;
        }
    }
}
```
