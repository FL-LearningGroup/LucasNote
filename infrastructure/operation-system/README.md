# [OperationSystem](https://en.wikipedia.org/wiki/Operating_system)
Operation System

# Processs vs Thread vs Task
进程简单的说是指执行在操作系统上的程序。线程是操作系统控制的最小单元， 线程执行在进程中，一个进行可以执行一个或多个线程。任务指一系列被加载进入内存中的指令。

+ **Process**  
A process is an instance of a computer program that is being executed. It contains the program code and its current activity. Depending on the operating system (OS), a process may be made up of multiple threads of execution that execute instructions concurrently. Process-based multitasking enables you to run the Java compiler at the same time that you are using a text editor. In employing multiple processes with a single CPU,context switching between various memory context is used. Each process has a complete set of its own variables.

+ **Thread**  
A thread is a basic unit of CPU utilization, consisting of a program counter, a stack, and a set of registers. A thread of execution results from a fork of a computer program into two or more concurrently running tasks. The implementation of threads and processes differs from one operating system to another, but in most cases, a thread is contained inside a process. Multiple threads can exist within the same process and share resources such as memory, while different processes do not share these resources. Example of threads in same process is automatic spell check and automatic saving of a file while writing. Threads are basically processes that run in the same memory context. Threads may share the same data while execution. Thread Diagram i.e. single thread vs multiple threads

+ **Task**  
A task is a set of program instructions that are loaded in memory.

![process-thread-task](https://github.com/FL-LearningGroup/OperationSystem/blob/main/process-thread-task.png)

# 视频教程

+ 清华操作系统: https://www.bilibili.com/video/BV1uW411f72n?from=search&seid=6757714211184732131&spm_id_from=333.337.0.0
