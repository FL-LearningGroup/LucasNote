# Requirement
+ Install vscode extension Hex Editor

# Start img steps

1. use command ["dd if=/dev/zero of=helloos.img count=1474560 bs=1"](https://www.runoob.com/linux/linux-comm-dd.html) to create img. Exeute above cmdle in gitbash.(Its execute very slowly in bash shell in Ubuntu)

2. Open file use vs code with [Hex Editor](https://marketplace.visualstudio.com/items?itemName=ms-vscode.hexeditor) extension. Then edit follow the sample of the book.

3. Run qemu-system-i386 helloos.img in bash shell. Executed result as following.

![os-start-from-the-img](./images/OSStartFromImg.png)

# Question
1. Why file size must is 1474560 byte(1440 x 1024byte)?
计算机读写软盘的时候，并不是一个字节一个字节地读写的，而是以512字节为一个单位进行读写。因此,软盘的512字节就称为一个扇区。

一张软盘的空间共有1440KB，也就是1474560字节，除以512得2880，这也就是说一张软盘共有2880个扇区。

2. The computer How to load code?
那为什么第一个扇区称为启动区呢？那是因为计算机首先从最初一个扇区开始读软盘，然后去检查这个扇区最后2个字节的内容。

如果这最后2个字节不是0x55 AA，计算机会认为这张盘上没有所需的启动程序，就会报一个不能启动的错误。

3. FAT12软盘
https://baike.baidu.com/item/FAT12/4958604?fr=aladdin

4. 文件大小为什么必须为 1474560 byte?
计算机读写软盘时，并不是一个字节一个字节读取的，而是以512字节为单位进行读写。

因此，软盘的512字节就称为一个扇区。一张软盘的空间共有1440KB，也就是1474560 byte. 除以512得2880个扇区。