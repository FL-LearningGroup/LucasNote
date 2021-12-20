## Connection String
Most database providers require some form of connection string to connect to the database.

## Asynchronous Programming
Following the .NEW standard, EF Core provides asynchronous counterparts to all asynchronous methods which perform I/O. Example:
+ context.SaveChanges()
+ contxt.SaveChangesAsync()

## Async LINQ operators 
In order to support executing LINQ queries asynchronously, EF Core provides a set of async extension methods which execute the query and return results.
```csharp
var blogs = await context.Blogs.Where(b => b.Rating > 3).ToListAsync();

var groupedHighlyRatedBlogs = await context.Blogs
    .AsQueryable()
    .Where(b => b.Rating > 3) // server-evaluated
    .AsAsyncEnumerable()
    .GroupBy(b => b.Rating) // client-evaluated
    .ToListAsync();
```

## Logging
Entity Framework Core (EF Core) generates log messages for operations such as executing a query or saving changes to the database.   
These can be accessed from any type of application through use of LogTo when configuring a DbContext instance.   
This configuration is commonly done in an override of DbContext.OnConfiguring. For example:
```csharp
protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    => optionsBuilder.LogTo(Console.WriteLine);
```

## DbContext pooling
AddDbContextPool enables pooling of DbContext instances.   
Context pooling can increase throughput in high-scale scenarios such as web servers by **reusing** context instances,rather than **creating new** instances for each request.

## Connection Resiliency
### Enable retriable while error occur
```csharp
protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
{
    optionsBuilder
        .UseSqlServer(
            @"Server=(localdb)\mssqllocaldb;Database=EFMiscellanous.ConnectionResiliency;Trusted_Connection=True;ConnectRetryCount=0",
            options => options.EnableRetryOnFailure());
}
```
### Execution strategies and transactions
You can group of operations that need to be treated as a unit.
```csharp
using (var db = new BloggingContext())
{
    var strategy = db.Database.CreateExecutionStrategy();

    strategy.Execute(() =>
    {
        using (var context = new BloggingContext())
        {
            using (var transaction = context.Database.BeginTransaction())
            {
                context.Blogs.Add(new Blog {Url = "http://blogs.msdn.com/dotnet"});
                context.SaveChanges();

                context.Blogs.Add(new Blog {Url = "http://blogs.msdn.com/visualstudio"});
                context.SaveChanges();

                transaction.Commit();
            }
        }
    });
}
```
