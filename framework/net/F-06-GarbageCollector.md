# NetMemory
https://www.jetbrains.com/help/dotmemory/NET_Memory_Management_Concepts.html#memory-release

# IDisposable Design Pattern

# Dispose and Finalized在垃圾回收步骤
GC捡垃圾有两个步骤，先看一遍各位是不是垃圾（调用析构器），第二步开始正式回收托管的垃圾（未托管的垃圾视而不见）。

注意，这里就出现问题了。GC调用析构器，析构器调用Dispose方法，Dispose把资源释放了。等GC回头再来捡垃圾的时候，发现刚刚还在的垃圾竟然没了？怎么就没了呢？随后较真的GC就在原地百思不得其解，一直在你耳边重复：“垃圾？垃圾！拉垃圾……”

所以，猿人不得不加上一个Dispose(bool)方法，传入一个参数，告诉Dispose要不要回收托管资源。

如果，在析构器中调用Dispose(bool)，就传入false，释放未托管的资源，不要释放托管资源。

如果，在Dispose中调用Dispose(bool)，就传入true，回收所有资源，并且调用GC,SuppressFinalize()，告诉GC这片垃圾我给承包了。

## 示例代码
https://docs.microsoft.com/en-us/dotnet/api/system.gc.suppressfinalize?view=net-5.0
