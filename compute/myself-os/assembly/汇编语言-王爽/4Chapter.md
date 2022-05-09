# 第一程序
一个源程序中所有将被计算所处理的信息：指令，数据，栈，被划分到不同的段中。

```assembly
assume cs:abc

abc segment

    mov ax,2
    mov ax,ax
    mov ax,ax

    mov ax,4c00H
    int 21H

abc ends

end
```