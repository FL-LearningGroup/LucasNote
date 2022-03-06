# Overview

**目标**: 把含有自制的操作系统的CR-ROM或软盘插入电脑，只要打开电源开关就能自动运行。

**步骤**: 在Windows系统上编写源代表 --> 同C语言编译器编译代码，生产机器语言文件 --> 对机器语言文件进行加工，生产软盘映像文件 --> 将硬件文件写入磁盘，作出含操作系统的启动盘

**内容构成:**
+ CPU基本知识
+ 汇编
+ C语言

## Environment and Tools
+ Windows 64bit
+ Ubuntu
    + Use [wsl](https://docs.microsoft.com/en-us/windows/wsl/install) install it on windows
    + [QEMU](https://www.qemu.org/): A generic and open source machine emulator and virtualizer
        - sudo apt-get install qemu-system: The command will install all system. Includes i386, x86_64, arm and so on.
+ vscode: [windows platform](https://code.visualstudio.com/download)
