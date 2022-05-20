# Core
+ Writing thread-safe code is at its core about managing access to state, and in particular to share mutable state.
+ 设计安全线程的要求
  - 识别形成对象状态的变量
  - 识别包含状态变量的不变量
  - 建立用于管理对对象状态的并发访问的策略

# Problems
+ If multiple threads access the same mutable state variable without appropriate synchronization your program is broken.
+ Resolve: There are three ways to fix it:
  - Don’t share the state variable across threads
  - Make the state variable immutable
  - Use synchronization whenever accessing the state variable
  
# Blogs
https://medium.com/swlh/race-conditions-locks-semaphores-and-deadlocks-a4f783876529

# Concepts

+ Locks

+ Deadlocks

+ Livelocks

+ Race Conditions
  - 多线程对一个share variable进行读写操作
 
```csharp
  public class RaceCondition
  {
      private int _counter = 0;
      private int _counterLock = 0;
      public int Counter { get => _counter; }
      public int CounterLock { get => _counterLock; }

      public void Next()
      {
          _counter++;
      }

      public void NextLock()
      {
          lock(this)
          {
              _counterLock++;
          }
      }
  }
  /**Test********************************************/
  /*
      RaceCondition raceCondition = new RaceCondition();
      Action<object> action = (object objec) => {
          for (int i = 1; i <= 10000; i++)
          {
              raceCondition.Next();
          }
          for (int i = 1; i <= 10000; i++)
          {
              raceCondition.NextLock();
          }
      };
      Task oneTask = new Task(action, "one task");
      Task twoTask = new Task(action, "two task");
      oneTask.Start();
      twoTask.Start();
      Task.WaitAll(new Task[] { oneTask,twoTask });
      Console.WriteLine("One task status: {0}, Two task status: {1}", oneTask.Status, twoTask.Status);
      Console.WriteLine("Race condition counter: {0}, counterlock: {1}", raceCondition.Counter, raceCondition.CounterLock);
  */
  /**Result: ********************************************
      One task status: RanToCompletion, Two task status: RanToCompletion
      Race condition counter: 14164, counterlock: 20000
  */
```
+ Semaphores

+ Starvations
