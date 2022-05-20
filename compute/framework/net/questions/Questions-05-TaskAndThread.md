https://stackoverflow.com/questions/13429129/task-vs-thread-differences

Thread is a lower-level concept: if you're directly starting a thread, you know it will be a separate thread,   
rather than executing on the thread pool etc.

Task is more than just an abstraction of "where to run some code" though - it's really just "the promise of a result in the future".   
So as some different examples:

+ Task.Delay doesn't need any actual CPU time; it's just like setting a timer to go off in the future
+ A task returned by WebClient.DownloadStringTaskAsync won't take much CPU time locally;  
  it's representing a result which is likely to spend most of its time in network latency or remote work (at the web server)
+ A task returned by Task.Run() really is saying "I want you to execute this code separately"; the exact thread on which that code executes depends on a number of factors.
