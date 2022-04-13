gcc
[objcopy](https://sourceware.org/binutils/docs/binutils/objcopy.html)

[objdump](https://man7.org/linux/man-pages/man1/objdump.1.html)

hexdump


$ gcc -c test.c     
$ objcopy -O binary -j .text test.o binfile
$ objdump -d test.o 
$ objdump -d -S -l -M intel critical.o &> critical.asm
$ hexdump -C binfile