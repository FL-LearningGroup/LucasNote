# 基础知识
汇编语言是直接在硬件之上工作的编程语言，我们首先要了解硬件体系的结构，才能有效的应用汇编语言

## 1.1 机器语言
机器语言是一列二进制数字。计算机将之转变为一列高低电平，以使计算机的电子器件受到驱动，进行运算。

每一种微处理器(CPU)，由于硬件设计换个内部结构的不同，就需要用不同的电平脉冲来控制，使它工作。所以每一种微处理器都有自己的机器指令集，也就是机器语言。

## 1.2 汇编语言的产生
汇编语言是机器指令便于记忆的书写格式。

## 1.3 汇编语言的组成

有以下3类指令组成
+ 汇编指令：机器码的助记符，有对应的机器码。
+ 伪指令：没有对应的机器码，由编译器执行，计算机并不执行。
+ 其他符号：如+，-，*，/等，由编译器识别，没有对应的机器码。

## 1.4 储存器
指令和数据在存储器中存放，也就是内存。CPU是从内存中读写数据的。

## 1.5 指令和数据
指令和数据都是以二进制存储的，CPU无法失败二进制数是指令还是数据。

## 1.6 存储单元
存储器被划分若干个存储单元，从0开始顺序编号。每个存储单元存储1Byte(8 bit)

## 1.7 CPU对存储器的读写。
CPU要进行数据的读写，必须和外部器件进行下面3类信息的交互。
+ 存储单元地址（地址信息）
+ 器件的选择，读或写的命令（控制信息）
+ 读或写的数据（数据信息)

CPU通过总线和其它芯片进行交互，根据传输数据的不同可分为，地址总线，控制总线，数据总线。
+ 地址总线： 寻址能力
+ 数据总线： 数据传输能力
+ 控制总线： CPU控制外围设备的能力

## 检测点1.1
1. 1个CPU的寻址能力分为8KB，那么他的地址总线为13
2. 1KB的存储器有128个存储单元，存储单元的编号从0x00到0x79.
3. 1KB的存储器可以存储1024个bit, 128个Byte.
4. 1GB = 1024^3Byte, 1MB = 1024^2Byte, 1KB = 1024Byte
5. 8086, 8088, 80286, 80386的地址总线宽度分别为16，20，24，32根，则它们的寻址能力分别为：6KB, 1MB, 4MB,2GB
6. 8086,8088,8086,80286,80386的数据总线分别为8根，8根，16根，16根，32根。则他们一次传送的数据为：1B, 1B, 2B, 2B, 4B
7. 从内存中读取1024字节的数据，8086至少要读取1024次， 80386至少要读取256次。
8. 在存储器中，数据和程序以二进制形式存放。

## 1.11 内存地址空间
CPU寻址空间

## 1.12 主板
主板上包含有CPU，存储器， 外围芯片组，扩展插槽。插槽一般插有RAM内存条和各类接口卡。

## 1.13 接口卡
接口卡是CPU和外围设备的桥梁，接口卡通过总线和CPU相连。CPU通过接口卡控制外围设备。

## 1.14 各类存储器芯片

PC机中各类存储器的逻辑连接

![1.7](./images//1.7.png)

## 1.15 内存地址空间
器件地址会被映射为内存地址，CPU通过操作内存地址进而操作器件。

![1.8](./images/1.8.png)

我们基于一个计算机硬件系统编程的时候，必须知道系统中的内存地址空间分配情况。

因为当我们想在 某类存储器中读写数据的时候，必须知道它的第一个单元的地址和最后一个单元的地址，才能保证读写操作是在预期的存储器中进行。