# FrOS

## Description

This is a simple x86 32 bit operating system written from scratch, based on Carlos Fenollosas [OS tutorial](https://github.com/cfenollosa/os-tutorial). It contains the following components:

1. Boot loader
2. Operating system kernel, including
    1. ISRs to handle CPU interrupts
    2. VGA driver
    3. Keyboard driver
    4. Shell
    5. Dynamic memory allocation

## Setup

### Install Assembler and Emulator

```bash
brew install qemu nasm
```

### Install Kernel Compiler

https://github.com/lordmilko/i686-elf-tools#mac-os-x

```
brew install i386-elf-binutils
brew install i386-elf-gcc
brew install i386-elf-gdb
```

```
export PATH="/usr/local/Cellar/x86_64-elf-binutils/<version>/bin/:/usr/local/Cellar/x86_64-elf-gcc/<version>/bin/:/usr/local/Cellar/i386-elf-gdb/<version>/bin:$PATH"
```

## Usage

### Boot

```
make run
```

### Debug

```
make debug
```

In GDB shell:

- Set breakpoint at function (e.g. `start_kernel`): `b start_kernel`
- Start execution: `c`
- Jump to next instruction: `n`
- Print variable: `p <variable_name>`

## Additional Resources

- [Writing a Simple Operating System — from Scratch](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
- [OS Dev Wiki](https://wiki.osdev.org/Meaty_Skeleton)
- [JamesM's Kernel Development Tutorials](https://web.archive.org/web/20160412174753/http://www.jamesmolloy.co.uk/tutorial_html/index.html)
- [BrokenThorn Entertainment's Operating System Development Series](http://www.brokenthorn.com/Resources/OSDevIndex.html)
- [The Little Book About OS Development](https://littleosbook.github.io/)
- [C Memory Allocation Functions](http://www.sunshine2k.de/articles/coding/cmemalloc/cmemory.html)

# 
nasm boot/mbr.asm -f bin -o boot/mbr.bin
nasm boot/kernel_entry.asm -f elf -o boot/kernel_entry.o
x86_64-elf-gcc -g -m32 -ffreestanding -c kernel/mem.c -o kernel/mem.o # -g for debugging
nasm cpu/interrupt.asm -f elf -o cpu/interrupt.o
x86_64-elf-gcc -g -m32 -ffreestanding -c kernel/util.c -o kernel/util.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c kernel/kernel.c -o kernel/kernel.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c drivers/display.c -o drivers/display.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c drivers/ports.c -o drivers/ports.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c drivers/keyboard.c -o drivers/keyboard.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c cpu/isr.c -o cpu/isr.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c cpu/idt.c -o cpu/idt.o # -g for debugging
x86_64-elf-gcc -g -m32 -ffreestanding -c cpu/timer.c -o cpu/timer.o # -g for debugging
x86_64-elf-ld -m elf_i386 -o kernel.bin -Ttext 0x1000 boot/kernel_entry.o kernel/mem.o cpu/interrupt.o kernel/util.o kernel/kernel.o drivers/display.o drivers/ports.o drivers/keyboard.o cpu/isr.o cpu/idt.o cpu/timer.o --oformat binary
cat boot/mbr.bin kernel.bin > os-image.bin
qemu-system-i386 -fda os-image.bin