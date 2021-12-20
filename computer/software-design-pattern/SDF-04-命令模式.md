## 原理
命令模式将**动作的请求者**从**动作的执行者**对象中解耦。把方法调用封装起来

## 场景： 设计家电遥控器API
### 描述
遥控器具有7个可编程的插槽（每个插槽都可以指定到一个不同家电装置，每个插槽都有对应的开关按钮。遥控器还具备一个整体的撤销按钮。家电控制类由  
厂商提供。例如电灯，风扇，热水器，音响设备等

### 需求描述
创建一组控制遥控器的API，让每个插槽都能控制一个或一组装置。请注意能够控制目前的装置和任何未来可能出现的装置。

### Questions
+ 什么是API(application programming interface)?

### 自设计
```csharp
#region Define Models
public class ControllerSwitch
{
    public bool ON { get; set; }
    public bool OFF { get; set; }
}
public class ApplianceController
{
  public ControllerSwitch Slot01 { get; set; }
  public ControllerSwitch Slot02 { get; set; }
  public ControllerSwitch Slot03 { get; set; }
  public ControllerSwitch Slot04 { get; set; }
  public ControllerSwitch Slot05 { get; set; }
  public ControllerSwitch Slot06 { get; set; }
  public ControllerSwitch Slot07 { get; set; }
  public bool Reset {get; set;}
}
#endregion
// The vendor appliance class need implement.
public interface IApplianceWork
{
    void InvokeFunction();
}

public interface IApplianceController
{
    void SendSignal(ApplianceController applianceController);
}

/**
* 1. Send control signal 
**/
public class ApplianceControllercClient: IApplianceController
{
    public Dictionary<ApplianceController, IApplianceWork> ControllerMatchAppliance { get; set;}
    public ApplianceController Controller {get; set;}
    
    public SendSignal(ApplianceController applianceController)
    {
        ControllerMatchAppliance[applianceController].InvokeFunction();
    }
}
```
### 总结
什么时候使用： 一个对象根据接受的信号，执行对应的功能。
