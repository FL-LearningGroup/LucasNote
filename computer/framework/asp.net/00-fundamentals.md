# The Startup class

+ Services required by the app are configured.
+ The app's required handling pipeline is defined, as a series of middleware components.

```csharp
public class Startup
{
    public void ConfigureServices(IServiceCollection servies)
    {
        ....
    }

    public void Configure(IApplicationBuilder app)
    {
        ....
    }
}
```

# [Dependency Injection(Services)](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0)

ASP.NET Core includes a built-in dependency injection(DI) framework that makes configured services available throughout an app.

Code to configure(or register) services is added to the Startup.ConfigureServices method.

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddDbContext<RazorPagesMovieContext>(options =>
        options.UseSqlServer(Configuration.GetConnectionString("RazorPagesMovieContext")));

    services.AddControllersWithViews();
    services.AddRazorPages();
}
```

Services are typically resolved from DI using constructor injection. With constructor injecttion, a class declares a constructor parameter

of either the required type or an interface. The DI framework provides an instance of the service at runtime.

```csharp
public class IndexModel : PageModel
{
    private readonly RazorPagesMovieContext _context;

    public IndexModel(RazorPagesMovieContext context)
    {
        _context = context;
    }

    // ...

    public async Task OnGetAsync()
    {
        Movies = await _context.Movies.ToListAsync();
    }
}
```

# Middleware

The request handling pipeline is composed as a series of middleware components. Each component performs operations on an `HttpContext` and either invokes the next middleware in the pipeline or terminates the reques.

By convention, a middleware component is added to the pipeline by invoking a `Use...` extension method in the `Startup.Configure` method.

For example, to enable rendering of the static files, call `UseStaticFiles`.

```csharp
public void Configure(IApplicationBuilder app)
{
    app.UseHttpsRedirection();
    app.UseStaticFiles();

    app.UseRouting();

    app.UseEndpoints(endpoints =>
    {
        endpoints.MapDefaultControllerRoute();
        endpoints.MapRazorPages();
    });
}
```

# Host

On startup, an ASP.NET Core app builds a host. The host encapsulates all of the app's resources, such as:

+ An HTTP server implementation
+ Middleware components
+ Logging
+ Dependency Injection services
+ Configuration

There are two different hosts:

+ .NET Generic Host
+ ASP.NET Core Web Host

The .NET Generic host is recommended. The ASP.NET Core Web Host is available only for backwards compatibilty.

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseStartup<Startup>();
            });
}
```

The `CreateDefaultBuilder` and `ConfigureWebHostDefaults` methods configure a host with a set of default options, such as:

+ Use `Kestrel` as the web server and enable IIS integration.
+ Load configuration from `appsetting.json`, `appsetting.{Environment Name}.json`, environment variables, command line arguments, and other configuration sources.
+ Send logging output to the console and debug providers.

# Servers

An ASP.NET Core app use an HTTP server implementation to listen for HTTP request. The server sufaces requests to the app as a set of request features composed into an `HttpContext`.

|Server | Windows | MacOS | Linux |
| :---- | :---    | :---  | :---- |
| Kestrel is a cross-platform web server. |Kestrel is often run in a reverse proxy configuration using IIS. In ASP.NET Core 2.0 or later, Kestrel can be run as a public-facing edge server exposed directly to the Internet. | ASP.NET Core provides the Kestrel cross-platform server implementation. In ASP.NET Core 2.0 or later, Kestrel can run as a public-facing edge server exposed directly to the Internet. Kestrel is often run in a reverse proxy configuration with Nginx or Apache.| ASP.NET Core provides the Kestrel cross-platform server implementation. In ASP.NET Core 2.0 or later, Kestrel can run as a public-facing edge server exposed directly to the Internet. Kestrel is often run in a reverse proxy configuration with Nginx or Apache. |
| IIS | HTTP Server is a server for Windows that uses IIS. With this server, the ASP.NET Core app and IIS run in the same process.|
|HTTP.sys |  is a server for Windows that isn't used with IIS. |

# Configuration

ASP.NET Core providers a configuration framework that gets a setting as name-vaule pairs from an ordered set of configuration providers.

Support configuration sources:

+ appsettings.json
+ environment variables
+ command line
+ more(az key vault)

# Environments

Execution environments, Usually environment is `Development`,`Staging`, and `Production`.

The ASP.NET Core read environemnt variables from the setting that such as environment variable(ASPNETCORE_ENVIRONMENT), command line and setting files. then store into `IWebHostEnvironemnt`. It was implementation that available anywhere in an app via DI.

```csharp
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }
    else
    {
        app.UseExceptionHandler("/Error");
        app.UseHsts();
    }

    app.UseHttpsRedirection();
    app.UseStaticFiles();

    app.UseRouting();

    app.UseEndpoints(endpoints =>
    {
        endpoints.MapDefaultControllerRoute();
        endpoints.MapRazorPages();
    });
}
```

## Logging

ASP.NET Core supports a logging API that works with a variety of build-in and thrid-pary logging providers. Available providers inlcude:

+ Console
+ Debug
+ Event Tracing on Windows
+ Windows Event Log
+ TraceSource
+ Azure App Service
+ Azure Application Insights

To create logs, resolve an ILogger<TCategoryName> service from dependency injection (DI) and call logging methods such as LogInformation. For example:

```csharp
public class TodoController : ControllerBase
{
    private readonly ILogger _logger;

    public TodoController(ILogger<TodoController> logger)
    {
        _logger = logger;
    }

    [HttpGet("{id}", Name = "GetTodo")]
    public ActionResult<TodoItem> GetById(string id)
    {
        _logger.LogInformation(LoggingEvents.GetItem, "Getting item {Id}", id);
        
        // Item lookup code removed.
        
        if (item == null)
        {
            _logger.LogWarning(LoggingEvents.GetItemNotFound, "GetById({Id}) NOT FOUND", id);
            return NotFound();
        }
        
        return item;
    }
}
```

# Routing

A route is a URL pattern that is mapped to a handler. The handler is typically a Razor page, an action method in an MVC controller, or a middleware. ASP.NET Core routing gives you control over the URLs used by your app.

For more information, see Routing in ASP.NET Core.

# Error handling

ASP.NET Core has built-in features for handling errors, such as:

+ A developer exception page
+ Custom error pages
+ Static status code pages
+ Startup exception handling

# Content root

The content root is the base path for:

+ The executable hosting the app (.exe).
+ Compiled assemblies that make up the app (.dll).
+ Content files used by the app, such as:
    - Razor files (.cshtml, .razor)
    - Configuration files (.json, .xml)
    - Data files (.db)

# Web root

The web root is the base path for public, static resource files, such as:

+ Stylesheets (.css)
+ JavaScript (.js)
+ Images (.png, .jpg)

By default, static files are served only from the web root directory and its sub-directories. **The web root path defaults to {content root}/wwwroot.**

```xml
<ItemGroup>
  <Content Update="wwwroot\local\**\*.*" CopyToPublishDirectory="Never" />
</ItemGroup>
```

In Razor .cshtml files, tilde-slash (~/) points to the web root. A path beginning with ~/ is referred to as a virtual path.