## Source Code
## Base Class:
```csharp
internal class DMGovermentAnnouncement
{
    public string Title { get; set; }
    public string Date { get; set; }
    public string DetailedUrl { get; set; }
}
```
## Code-1: Compile Passed
```csharp
public abstract class Resource<T>: IWorkSiteInput, IWorkSiteOutput
{
    public abstract List<T> GetResourceData();
}

internal class ResAnnouncement : Resource<DMGovermentAnnouncement>, IResourceEventHandle
{
    public override List<DMGovermentAnnouncement> GetResourceData()
    {
        return null;
    }
}
```

## Code-2: Compile Failed
```csharp
public abstract class Resource: IWorkSiteInput, IWorkSiteOutput
{
    public abstract List<T> GetResourceData() where: class;
}

internal class ResAnnouncement : Resource, IResourceEventHandle
{
    public override List<T> GetResourceData() where: DMGovermentAnnouncement
    {
        return null;
    }
}
```
