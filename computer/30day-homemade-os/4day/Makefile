TOOLPATH = ../tools
CREATEOSIMG = $(TOOLPATH)/create-os-img.sh
DEL = rm

default:
	make img

ipl.bin: ipl.asm Makefile
	nasm ipl.asm -o ipl.bin -l ipl.lst

asmhead.bin: asmhead.asm Makefile
	nasm asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfunc.o: nasmfunc.asm Makefile
	nasm -g -f elf nasmfunc.asm -o nasmfunc.o

bootpack.hrb: bootpack.c nasmfunc.o Makefile
# ref command: gcc -march=i486 -m32 -nostdlib -T har.ld -g -fno-pic bootpack.c nasmfunc.o -o bootpack.hrb
	gcc -march=i486 -m32 -nostdlib -g -fno-pic bootpack.c nasmfunc.o -o bootpack.hrb

haribote.sys: asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img: ipl.bin haribote.sys Makefile
# mformat -f 1440 -C -B kernel.bin -i haribote.img
# mcopy haribote.sys -i haribote.img
	cat ipl.bin haribote.sys > haribote.img
	qemu-img resize -f raw haribote.img 1474560

compile:
	make ipl.bin
	make asmhead.bin
	make nasmfunc.o
	make bootpack.hrb
	make haribote.sys
	make haribote.img

run:
	qemu-system-i386 -fda haribote.img

clean:
	-$(DEL) *.lst 
	-$(DEL) *.bin 
	-$(DEL) *.sys 
	-$(DEL) *.img 
	-$(DEL) *.hrb
	-$(DEL) *.o